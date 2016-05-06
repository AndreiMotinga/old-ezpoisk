class User < ActiveRecord::Base
  include OmniLogin
  acts_as_voter
  # Include default devise modules. Others available are:
  # :validatable, :confirmable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
    :trackable, :timeoutable, :lockable, :async, :omniauthable,
    :omniauth_providers => [:facebook, :google_oauth2, :vkontakte]

  after_create :send_emails
  after_create :create_user_profile

  has_many :re_privates, dependent: :destroy
  has_many :re_commercials, dependent: :destroy
  has_many :jobs, dependent: :destroy
  has_many :sales, dependent: :destroy
  has_many :services, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :pictures, dependent: :destroy
  has_many :questions
  has_many :answers
  has_one  :profile, dependent: :destroy

  has_many :favorites, dependent: :destroy
  has_many :subscriptions, dependent: :destroy
  has_many :partners, dependent: :destroy

  validates :email, presence: true, uniqueness: true

  delegate :name, to: :profile, prefix: true
  delegate :phone, to: :profile, prefix: true
  delegate :state_id, to: :profile, prefix: true
  delegate :city_id, to: :profile, prefix: true

  def role?(val)
    role.to_sym == val
  end

  def subscribed?(q_id)
    Subscription.exists?(user_id: id, question_id: q_id)
  end

  def name_to_show
    return profile.name if profile.name?
    email
  end

  private

  def send_emails
    SlackNotifierJob.perform_async(id, "User")
    UserMailerJob.perform_async(id)
  end

  def create_user_profile
    # user.create_profile rails built in method
    create_profile
  end
end
