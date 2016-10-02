class User < ActiveRecord::Base
  include OmniLogin
  acts_as_voter
  acts_as_mappable
  include ListingHelpers
  # Include default devise modules. Others available are:
  # :validatable, :confirmable, :timeoutable,
  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
         :trackable, :lockable, :async, :omniauthable,
         omniauth_providers: [:facebook, :google_oauth2, :vkontakte]

  after_create :send_emails

  belongs_to :state
  belongs_to :city

  has_many :re_privates, dependent: :destroy
  has_many :jobs, dependent: :destroy
  has_many :sales, dependent: :destroy
  has_many :services, dependent: :destroy
  has_many :stripe_subscriptions, through: :services
  has_many :posts, dependent: :destroy
  has_many :questions
  has_many :answers
  has_many :reviews

  has_many :favorites, dependent: :destroy
  has_many :subscriptions, dependent: :destroy
  has_many :partners, dependent: :destroy
  has_many :points
  has_many :entries
  has_many :deactivations
  has_many :images, class_name: "Picture", dependent: :destroy
  has_many :pictures, as: :imageable, dependent: :destroy

  validates :email, presence: true, uniqueness: true

  scope :week, -> { where("created_at > ?", Date.today.at_beginning_of_week) }
  scope :today, -> { where("created_at > ?", Date.today) }

  has_attached_file(:avatar,
                    styles: { thumb: "50x50#", medium: "100x100#" },
                    default_url: "default-avatar.png")
  validates_attachment_content_type :avatar, content_type: %r{\Aimage\/.*\Z}
  attr_reader :avatar_remote_url
  def avatar_remote_url=(url_value)
    if url_value.present?
      self.avatar = URI.parse(url_value)
      @avatar_remote_url = url_value
    end
  end

  has_attached_file(
    :cover,
    styles: { large: "780x390#" },
    default_url: "https://s3.amazonaws.com/ezpoisk/default_cover.jpg")
  validates_attachment_content_type :cover, content_type: %r{\Aimage\/.*\Z}

  def subscribed?(id, type)
    subscriptions.exists?(subscribable_type: type, subscribable_id: id)
  end

  def name_to_show
    name.present? ? name : email
  end

  def show_url
    Rails.application.routes.url_helpers.user_url(self)
  end

  def new_email
    return "" if admin?
    email
  end

  def editor?
    admin? || role == "editor"
  end

  def can_edit?(record)
    self == record.user || admin?
  end

  def team_member?
    admin? || editor?
  end

  def listings
    entries.listings.includes(enterable: [:state, :city])
  end

  def reviewed?(service_id)
    reviews.where(service_id: service_id).any?
  end

  def find_favorite(prms)
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
end
