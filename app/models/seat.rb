class Seat < ActiveRecord::Base
  belongs_to :area
  has_many :orderitems, dependent: :destroy
  has_many :orders, through: :orderitems

  def name_with_initial
    # "#{locate_x}. #{locate_y}"
  end
end
