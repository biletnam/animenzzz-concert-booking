class Area < ActiveRecord::Base
  belongs_to :recital
  has_many :seats, dependent: :destroy

  validates :klass, presence: true
  validates :klass, uniqueness: true

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
