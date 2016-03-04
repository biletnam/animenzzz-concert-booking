class Area < ActiveRecord::Base
  belongs_to :recital
  has_many :seats, dependent: :destroy
end
