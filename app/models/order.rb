class Order < ActiveRecord::Base
  belongs_to :user
  has_many :orderitems, dependent: :destroy
  has_many :seats, through: :orderitems
end
