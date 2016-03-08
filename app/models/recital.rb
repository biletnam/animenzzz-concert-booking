class Recital < ActiveRecord::Base
  has_attached_file :poster, default_url: '/images/recitals/poster'
  validates_attachment_content_type :poster, content_type: /\Aimage/
  validates_attachment_file_name :poster, matches: [/png\Z/, /jpe?g\Z/]

  has_attached_file :venue_image, default_url: '/images/recitals/:venue_image'
  validates_attachment_content_type :venue_image, content_type: /\Aimage/
  validates_attachment_file_name :venue_image, matches: [/png\Z/, /jpe?g\Z/]
  has_many :areas, dependent: :destroy
end
