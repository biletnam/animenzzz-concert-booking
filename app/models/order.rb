class Order < ActiveRecord::Base
  enum state: [:wait, :paid, :deliveried, :received]
  belongs_to :user
  has_many :orderitems, dependent: :destroy
  has_many :seats, through: :orderitems

  before_save :set_apply_time

  def set_default_state
  	self.state ||= :wait
  end

  def set_apply_time
  	self.apply_time = Time.now + 30.minutes
  end

  # def total_price
  # 	@total_price ||= self.seats.collect { |s| s.price }.sum
  # end 		
end
