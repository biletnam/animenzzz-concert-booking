class Order < ActiveRecord::Base
  extend FriendlyId
  friendly_id :slug_candidates, use: [:slugged, :finders]

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

  def slug_candidates
    Time.now.strftime('%Y%m%d%w%H%M%S')
  end	
end
