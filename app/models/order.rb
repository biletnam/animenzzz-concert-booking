class Order < ActiveRecord::Base
  extend FriendlyId
  friendly_id :slug_candidates, use: [:slugged, :finders]

  enum status: [:wait, :paid, :deliveried, :received, :overdue]

  belongs_to :user
  has_many :orderitems,
           inverse_of: :order,
           dependent: :destroy
  has_many :seats, through: :orderitems


  before_save :set_default_state, :total_price
  before_destroy :return_seats

  def set_default_state
  	self.status ||= :wait
  end

  def total_price
    self.price ||= self.seats.collect {|p| p.price.price }.sum
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

  def Order.set_overdue_order
    # Order.all.each do |order|
    #   if order.seats.first.area.recital.city == '成都'
    #     if Time.now > order.apply_time and order.status == 'wait'
    #       order.return_seats
    #       order.status = :overdue
    #       order.save!
    #     end
    #   end
    # end

    # orders = Order.joins(seats: [area: [:recital]]).where(recitals: {city: "武汉"})
    # orders.each do |order|
    #   if Time.now > order.apply_time and order.status == 'wait'
    #     order.return_seats
    #     order.status = :overdue 
    #     order.save!
    #   end
    # end
  end

  def slug_candidates
    Time.now.strftime('%Y%m%d%w%H%M%S')
  end	
end
