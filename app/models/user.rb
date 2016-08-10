class User < ActiveRecord::Base
  include OmniLogin
  acts_as_voter
  acts_as_mappable
  include ViewHelpers
  # Include default devise modules. Others available are:
  # :validatable, :confirmable, :timeoutable,
  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
         :trackable, :lockable, :async, :omniauthable,
         omniauth_providers: [:facebook, :google_oauth2, :vkontakte]

  after_create :send_emails
  after_create :create_user_gallery

  belongs_to :state
  belongs_to :city
  has_one :gallery

  has_many :re_privates, dependent: :destroy
  has_many :re_commercials, dependent: :destroy
  has_many :jobs, dependent: :destroy
  has_many :sales, dependent: :destroy
  has_many :services, dependent: :destroy
  has_many :stripe_subscriptions, through: :services
  has_many :posts, dependent: :destroy
  has_many :questions
  has_many :answers

  has_many :favorites, dependent: :destroy
  has_many :subscriptions, dependent: :destroy
  has_many :partners, dependent: :destroy
  has_many :points
  has_many :entries
  has_many :pictures, dependent: :destroy

  validates :email, presence: true, uniqueness: true

  has_attached_file(:avatar,
                    styles: { thumb: "50x50#", medium: "160x160#" },
                    default_url: "default-avatar.png")
  validates_attachment_content_type :avatar, content_type: %r{\Aimage\/.*\Z}

  has_attached_file(
    :cover,
    styles: { large: "800x400#" },
    default_url: "https://s3.amazonaws.com/ezpoisk/default_cover.jpg")
  validates_attachment_content_type :cover, content_type: %r{\Aimage\/.*\Z}

  def self.this_week
    where("created_at > ?", Date.today.at_beginning_of_week).count
  end

  def role?(val)
    role.to_sym == val
  end

  def subscribed?(id, type)
    subscriptions.exists?(subscribable_type: type, subscribable_id: id)
  end

  def name_to_show
    name.present? ? name : email
  end

  def favorite(prms)
    favorites.where(
      favorable_id: prms[:favorable_id],
      favorable_type: prms[:favorable_type],
      saved: prms[:saved],
      hidden: prms[:hidden]
    ).first
  end

  private

  def send_emails
    SlackNotifierJob.perform_async(id, "User")
    UserMailerJob.perform_async(id)
  end

  def create_user_gallery
    create_gallery
  end
end
