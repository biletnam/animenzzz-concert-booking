class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @orders = current_user.orders.order('created_at DESC')
  end

  def show
    @order = current_user.orders.find(params[:id])
  end

  def new
    @order = Order.new

    seat_ids = []

    seat_data = params[:seats]

    if seat_data == nil then
      flash[:alert] = I18n.t('Please choose at leat one seat then continue')
      redirect_to :back and return
    end

    seat_data.each do |data|
      attrs = data.split(',')
      area = Area.where(klass: attrs[0]).first
      seat = area.seats.where(locate_x: attrs[1], locate_y: attrs[2]).first

      if seat.sold then
        flash[:alert] = I18n.t('Sorry, some seat has already sold')
        redirect_to :back and return
      end
      
      @order.seats << seat
      seat_ids << seat.id
    end

    if @order.seats.size > 4
      flash[:alert] = I18n.t('Seats number more than 4!')
      redirect_to :back and return
    end

    session[:ids] = seat_ids

    @order.total_price
  end

  def create
    @order = Order.new(secure_params)
    seats = Seat.find(session[:ids])

    Seat.transaction do
      seats.each do |seat|
        if seat.sold then
          flash[:alert] = I18n.t('Sorry, some seat has already sold')
          redirect_to :back and return
        end
        seat.lock!
        seat.set_sold
        seat.save
      end

      @order.seats << seats

      if @order.save
        OrderMailer.success_mail(current_user, @order).deliver_later
      end 

      current_user.orders << @order
      # send_message
    end

    # send_pingpp @order.id

    redirect_to orders_path
  end

  def destroy
    @order = current_user.orders.find(params[:id])
    @order.return_seats
    @order.destroy
  end


  # def store_seat_ids
  #   seats = params[:seat_ids]
  #   seat
  # end

  private

  def secure_params
    params.require(:order).permit(:address, :phone, :name, :seat_ids => [])
  end

  def send_message
    post_url = 'http://gw.api.taobao.com/router/rest'
    options = {
      app_key: '23333071',
      format: 'json',
      method: 'alibaba.aliqin.fc.sms.num.send',
      timestamp: @order.created_at.strftime("%Y-%m-%d %H:%M:%S"), 
      sign_method: 'md5',
      v: '2.0',
      rec_num: @order.phone,
      sms_type: 'normal',
      sms_free_sign_name: '大鱼测试',
      sms_param: '{"code":"123","product":"Test"}',
      sms_template_code: 'SMS_6770530'
    }

    options = sort_options(options)
    md5_str = encrypt(options)
    post_request(post_url, options.merge(sign: md5_str))
  end

  def sort_options(**arg)
    arg.sort_by{|k,v| k}.to_h
  end

  def encrypt(**arg)
    app_secret = '726e9ae8fdfa3a45b8c930d229fc497e'
    _arg = arg.map{|k,v| "#{k}#{v}"}
    md5("#{app_secret}#{_arg.join("")}#{app_secret}").upcase
  end

  def md5(arg)
    Digest::MD5.hexdigest(arg)
  end

  def post_request(uri, options)
    response = ""
    url = URI.parse(uri)
    Net::HTTP.start(url.host, url.port) do |http|
      req = Net::HTTP::Post.new(url.path)
      req.set_form_data(options)
      response = http.request(req).body
    end
    JSON(response)
  end
end