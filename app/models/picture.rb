class Picture < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]

  validates :name,	uniqueness: true
  validates :name,  presence: 	true


  has_attached_file :photo,
                    default_url: "video_areuok.jpg",
                    url: '/attachments/:class/:id/:attachment/:filename',
                    path: ':rails_root/public/attachments/:class/:id/:attachment/:filename'
  validates_attachment_content_type :photo, content_type: /\Aimage\/.*\Z/
  validates_attachment_file_name :photo, matches: [/png\Z/, /jpe?g\Z/]

end
