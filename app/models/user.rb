class User < ActiveRecord::Base
  include OmniLogin
  include Mappable
  acts_as_voter
  acts_as_mappable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
         :trackable, :lockable, :async, :omniauthable, :lastseenable,
         omniauth_providers: [:facebook, :google_oauth2, :vkontakte]

  after_create :run_notifications

  belongs_to :state
  belongs_to :city

  has_many :listings, dependent: :destroy
  has_many :questions
  has_many :answers
  has_many :reviews
  has_many :comments
  has_many :posts

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

  # todo rename to display_name
  def name_to_show
    name.present? ? name : email
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

  def address
    "#{street} #{city.try(:name)} #{state.try(:name)} #{zip}".strip
  end

  private

  def run_notifications
    SlackNotifierJob.perform_async(id, "User")
    UserMailerJob.perform_async(id)
  end
end
