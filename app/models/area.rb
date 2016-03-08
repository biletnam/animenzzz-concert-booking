class Area < ActiveRecord::Base
  belongs_to :recital
  has_many :seats, dependent: :destroy

  def seat_ids
  	[]
  end
end
