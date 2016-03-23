class Order < ActiveRecord::Base
  enum status: [:wait, :paid, :deliveried, :received, :overdue]

  belongs_to :user
  has_many :orderitems,
           inverse_of: :order,
           dependent: :destroy
  has_many :seats, through: :orderitems


  before_save :set_default_state, :set_apply_time, :total_price
  before_destroy :return_seats

  def set_default_state
  	self.status ||= :wait
  end

  def set_apply_time
  	self.apply_time = Time.now + 30.minutes
  end

  def total_price
    self.price ||= self.seats.collect {|p| p.price.price }.sum
  end

  def get_status
    case self.status
    when 'wait'
      '待付款'
    when 'paid'
      '已付款'
    when 'deliveried' 
      '已寄送'
    else
      '已签收'
    end
  end

  def already_sold?
    self.seats.each {|s| return true if s.sold}
  end

  def return_seats
    if self.status == 'wait' then
      self.seats.each do |seat|
        seat.sold = false
        seat.save
      end
    end
  end

  def destroy_overdue_order
  end	
end
