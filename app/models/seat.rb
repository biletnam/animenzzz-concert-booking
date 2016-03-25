class Seat < ActiveRecord::Base
  belongs_to :area
  belongs_to :price
  has_many :orderitems, dependent: :destroy
  has_many :orders, through: :orderitems

  def name_with_initial
    # "#{locate_x}. #{locate_y}"
  end

  def set_sold
  	self.sold = true
  end

  def get_position
    position = nil
    if self.locate_x == 0 then
      position = self.locate_y.to_s + '号'
    else
      position = self.locate_x.to_s + '排' + locate_y.to_s + '列'
    end
    position
  end
end
