class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable,  and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
    :trackable, :timeoutable, :validatable, :lockable, :async
  after_create :geolocate_user, :notify_admin

  acts_as_voter

  belongs_to :state
  belongs_to :city

  has_many :re_agencies, dependent: :destroy
  has_many :re_finances, dependent: :destroy
  has_many :re_privates, dependent: :destroy
  has_many :re_commercials, dependent: :destroy
  has_many :job_agencies, dependent: :destroy
  has_many :jobs, dependent: :destroy
  has_many :sales, dependent: :destroy
  has_many :services, dependent: :destroy
  has_many :posts
  has_many :pictures
  has_many :questions
  has_many :answers

  has_attached_file :avatar,
    styles: { thumb: "50x50#", medium: "200x200#" },
    :s3_protocol => :https,
    default_url: "default-avatar.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  def role?(val)
    role.to_sym == val
  end

  def timeout_in
    self.admin? ? 2.hours : 7.days
  end

  private

  def geolocate_user
    GeolocateUserJob.perform_async(id)
  end

  def notify_admin
    AdminMailerJob.perform_async(id, "User")
    SlackNotifierJob.perform_async(id, "User")
  end
end
