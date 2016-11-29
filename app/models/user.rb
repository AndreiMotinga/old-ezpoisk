class User < ActiveRecord::Base
  include OmniLogin
  acts_as_voter
  acts_as_mappable
  include ListingHelpers # todo shouldnt be her
  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
         :trackable, :lockable, :async, :omniauthable, :lastseenable,
         omniauth_providers: [:facebook, :google_oauth2, :vkontakte]

  after_create :send_emails
  after_save :invalidate_cache

  # todo what is it for?
  def self.serialize_from_session(key, salt)
    single_key = key.is_a?(Array) ? key.first : key
    Rails.cache.fetch("user:#{single_key}") do
      User.where(id: single_key).entries.first
    end
  end

  belongs_to :state
  belongs_to :city

  has_many :listings, dependent: :destroy
  has_many :questions
  has_many :answers
  has_many :reviews
  has_many :comments

  has_many :partners, dependent: :destroy
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

  def new_phone
    return "" if admin?
    phone
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

  def online?
    last_seen > 5.minutes.ago
  end

  def logo
    avatar(:thumb)
  end

  private

  def send_emails
    SlackNotifierJob.perform_async(id, "User")
    UserMailerJob.perform_async(id)
  end

  def invalidate_cache
    Rails.cache.delete("user:#{id}")
  end
end
