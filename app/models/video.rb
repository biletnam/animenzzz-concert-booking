class Video < ActiveRecord::Base
  extend FriendlyId
  friendly_id :slug_candidates, use: [:slugged, :finders]

  validates :name,	uniqueness: true
  validates :name,  presence:   true



  has_attached_file :screenshot, 
  					default_url: 'video_areuok.jpg',
  					styles: { large: "600x340>", medium: "300x170>" },
  					url: '/attachments/:class/:id/:attachment/:style/:filename',
  					path: ':rails_root/public/attachments/:class/:id/:attachment/:style/:filename'
  validates_attachment_content_type :screenshot, content_type: /\Aimage/
  validates_attachment_file_name :screenshot, matches: [/png\Z/, /jpe?g\Z/]

  def slug_candidates
  	begin
      return /(^.*?)\s?\(/.match(self.name)[1]
    rescue
      return ''
    end
  end

  # we just temporarily 'reuse' the link
  def avId
    begin
      /\/video\/av(\d+)/.match(self.link)[1]
    rescue
      ''
    end
  end
end
