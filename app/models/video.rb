class Video < ActiveRecord::Base
  has_attached_file :screenshot, 
  					default_url: 'video_areuok.jpg',
  					styles: { large: "600x340>", medium: "300x170>" },
  					url: '/attachments/:class/:id/:attachment/:style/:filename',
  					path: ':rails_root/public/attachments/:class/:id/:attachment/:style/:filename'
  validates_attachment_content_type :screenshot, content_type: /\Aimage/
  validates_attachment_file_name :screenshot, matches: [/png\Z/, /jpe?g\Z/]

end
