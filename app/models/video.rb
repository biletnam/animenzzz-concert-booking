class Video < ActiveRecord::Base
  has_attached_file :screenshot, 
  					default_url: 'leijun.png',
  					url: '/attachments/:class/:id/:attachment/:filename',
  					path: ':rails_root/public/attachments/:class/:id/:attachment/:filename'
  validates_attachment_content_type :screenshot, content_type: /\Aimage/
  validates_attachment_file_name :screenshot, matches: [/png\Z/, /jpe?g\Z/]

end
