class Price < ActiveRecord::Base
  extend FriendlyId
  friendly_id :price, use: [:slugged, :finders]

  has_many :seats

  validates :price, uniqueness: true
  validates :price,  presence: 	true


end
