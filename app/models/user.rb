class User < ActiveRecord::Base
  include OmniLogin
  # Include default devise modules. Others available are:
  # :validatable, :confirmable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
    :trackable, :timeoutable, :lockable, :async, :omniauthable,
    :omniauth_providers => [:facebook, :google_oauth2, :vkontakte]
  after_create :geolocate_user, :send_emails

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

  has_many :favorites
  has_many :subscriptions

  validates :email, presence: true, uniqueness: true

  has_attached_file(:avatar,
                    styles: { thumb: "50x50#", medium: "200x200#" },
                    default_url: "default-avatar.png")
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  def role?(val)
    role.to_sym == val
  end

  def timeout_in
    2.hours if admin?
  end

  def subscribed?(q_id)
    Subscription.exists?(user_id: id, question_id: q_id)
  end

  private

  def geolocate_user
    GeolocateUserJob.perform_async(id)
  end

  def send_emails
    AdminMailerJob.perform_async(id, "User")
    SlackNotifierJob.perform_async(id, "User")
    UserMailerJob.perform_async(id)
  end
end
