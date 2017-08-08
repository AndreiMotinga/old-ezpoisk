class User < ActiveRecord::Base
  include OmniLogin
  acts_as_taggable
  acts_as_voter
  devise :database_authenticatable, :rememberable, :trackable, :omniauthable,
    :lastseenable, omniauth_providers: [:facebook, :google_oauth2, :vkontakte]

  has_one :contact
  has_many :listings, dependent: :destroy
  has_many :questions
  has_many :answers
  has_many :reviews
  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :experiences, dependent: :destroy
  has_many :images, class_name: "Picture", dependent: :destroy

  validates :email, presence: true, uniqueness: true
  validates :name, presence: true

  after_create :create_contact
  after_create :notify

  scope :week, -> { where("created_at > ?", Date.today.at_beginning_of_week) }
  scope :today, -> { where("created_at > ?", Date.today) }

  has_attached_file(:avatar,
                    styles: { thumb: "50x50#", medium: "100x100#" },
                    default_url: "default-avatar.png")
  validates_attachment_content_type :avatar, content_type: %r{\Aimage\/.*\Z}
  # for omnouth login
  def avatar_remote_url=(url_value)
    if url_value.present?
      self.avatar = URI.parse(url_value)
      @avatar_remote_url = url_value
    end
  end

  def show_url
    Rails.application.routes.url_helpers.user_url(self)
  end

  def can_edit?(record)
    self == record.user || admin?
  end

  def online?
    last_seen > 5.minutes.ago
  end

  def ez?
    email == "ez@ezpoisk.com"
  end

  private

  def notify
    SlackNotifierJob.perform_async(id, "User")
  end
end
