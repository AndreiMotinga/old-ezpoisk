class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :validatable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
    :trackable, :timeoutable, :lockable, :async, :omniauthable,
    :omniauth_providers => [:facebook, :google_oauth2]
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

  has_attached_file(:avatar,
                    styles: { thumb: "50x50#", medium: "200x200#" },
                    default_url: "default-avatar.png")
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  # todo extract to some module
  def self.from_omniauth(auth)
    # user logged in previously thourgh this provider
    user = User.where(provider: auth.provider, uid: auth.uid).first
    return user if user

    # user logged in previously thourgh other provider
    user = User.find_by_email(auth.info.email)
    return user if user

    # create user if none of the above
    User.create(name: name_from_omniauth(auth.info),
                email: auth.info.email,
                password: Devise.friendly_token[0, 20],
                provider: auth.provider,
                uid: auth.uid)
  end

  def self.name_from_omniauth(info)
    return info.name if info.name.present? # facebook case
    "#{info.first_name} #{info.last_name}" if info.first_name && info.last_name
  end

  def role?(val)
    role.to_sym == val
  end

  def timeout_in
    admin? ? 2.hours : 7.days
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
