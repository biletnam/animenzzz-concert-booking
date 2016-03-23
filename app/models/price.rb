class Price < ActiveRecord::Base
  extend FriendlyId
  friendly_id :price, use: [:slugged, :finders]

  has_many :seats
end
