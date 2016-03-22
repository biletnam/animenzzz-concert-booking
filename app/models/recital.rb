class Recital < ActiveRecord::Base
  has_attached_file :poster, 
  					default_url: 'poster.png',
  					url: '/attachments/:class/:id/:attachment/:filename',
  					path: ':rails_root/public/attachments/:class/:id/:attachment/:filename'
  validates_attachment_content_type :poster, content_type: /\Aimage/
  validates_attachment_file_name :poster, matches: [/png\Z/, /jpe?g\Z/]

  has_attached_file :venue_image,
  					default_url: 'area-map.jpg',
  					url: '/attachments/:class/:id/:attachment/:filename',
  					path: ':rails_root/public/attachments/:class/:id/:attachment/:filename'

  validates_attachment_content_type :venue_image, content_type: /\Aimage/
  validates_attachment_file_name :venue_image, matches: [/png\Z/, /jpe?g\Z/]

  has_attached_file :index_image,
            default_url: 'area-map.jpg',
            url: '/attachments/:class/:id/:attachment/:filename',
            path: ':rails_root/public/attachments/:class/:id/:attachment/:filename'

  validates_attachment_content_type :index_image, content_type: /\Aimage/
  validates_attachment_file_name :index_image, matches: [/png\Z/, /jpe?g\Z/]

  has_many :areas, dependent: :destroy


  def sold_out?
    self.areas.each do |area|
  	  area.seats.each do |seat|
  		return false unless seat.sold
  	  end
  	end
  	true
  end

  def split_city
    self.city.split(//).join('<br />').html_safe
  end
end
