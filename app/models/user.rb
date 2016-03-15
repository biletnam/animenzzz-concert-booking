class User < ActiveRecord::Base
  enum role: [:user, :vip, :admin]
  after_initialize :set_default_role, :if => :new_record?

  has_attached_file :avatar,
                    styles: { large: "300x300>", medium: "100x100>", thumb: "40x40>" },
                    default_url: "default-thumb.png",
                    url: '/attachments/:class/:id/:attachment/:style/:filename',
                    path: ':rails_root/public/attachments/:class/:id/:attachment/:style/:filename'
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  def set_default_role
    self.role ||= :user
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :orders, dependent: :destroy
end
