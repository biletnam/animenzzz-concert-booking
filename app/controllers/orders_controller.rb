class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
  	@orders = current_user.orders.sort_by {|o| o.created_at }
  end

  def show
  	@order = current_user.orders.find(params[:id])
  end

  def new
    @order = Order.new

    params[:area][:seat_ids].pop
    session[:ids] = params[:area][:seat_ids]

    seats = Seat.find(session[:ids])
    @order.seats << seats

    @order.total_price
  end

  def create
    @order = Order.new(secure_params)
    seats = Seat.find(session[:ids])

    # if @order.already_sold? then
    # end

    Seat.transaction do
      seats.each do |seat|
        seat.lock!
        seat.set_sold
        seat.save
      end

      @order.seats << seats

      @order.save 

      current_user.orders << @order
    end

    # send_pingpp @order.id

  	redirect_to orders_path
  end

  def destroy
  	@order = current_user.orders.find(params[:id])
  	@order.destroy
  end


  def store_seat_ids
    # seats = params[:seat_ids]
    # seat
  end

  private

  def secure_params
  	params.require(:order).permit(:address, :phone, :name, :seat_ids => [])
  end
end