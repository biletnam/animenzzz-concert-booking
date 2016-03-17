class Area < ActiveRecord::Base
  belongs_to :recital
  has_many :seats, dependent: :destroy

  validates :username, presence: true
  validates :username, uniqueness: true

  def seat_ids
  	[]
  end

  def sold_out?
  	self.seats.each do |seat|
  	  return false unless seat.sold
  	end
  	true
  end
end
