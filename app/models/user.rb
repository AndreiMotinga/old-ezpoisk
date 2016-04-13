class User < ActiveRecord::Base
  include OmniLogin
  # todo do you need this ?
  acts_as_voter
  # Include default devise modules. Others available are:
  # :validatable, :confirmable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
    :trackable, :timeoutable, :lockable, :async, :omniauthable,
    :omniauth_providers => [:facebook, :google_oauth2, :vkontakte]

  after_create :send_emails
  after_create :create_user_profile

  has_many :re_agencies, dependent: :destroy
  has_many :re_finances, dependent: :destroy
  has_many :re_privates, dependent: :destroy
  has_many :re_commercials, dependent: :destroy
  has_many :job_agencies, dependent: :destroy
  has_many :jobs, dependent: :destroy
  has_many :sales, dependent: :destroy
  has_many :services, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :pictures, dependent: :destroy
  has_many :questions
  has_many :answers
  has_one  :profile, dependent: :destroy

  has_many :favorites
  has_many :subscriptions
  has_many :partners

  validates :email, presence: true, uniqueness: true

  def role?(val)
    role.to_sym == val
  end

  def timeout_in
    2.hours if admin?
  end

  def subscribed?(q_id)
    Subscription.exists?(user_id: id, question_id: q_id)
  end

  def name_to_show
    return profile.name if profile.name.present?
    email
  end

  private

  def send_emails
    AdminMailerJob.perform_async(id, "User")
    SlackNotifierJob.perform_async(id, "User")
    UserMailerJob.perform_async(id)
  end

  def create_user_profile
    # user.create_profile rails built in method
    create_profile
  end
end
