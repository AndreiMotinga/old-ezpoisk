# frozen_string_literal: true

class User < ActiveRecord::Base
  include OmniLogin
  include Impressionable

  include PgSearch
  pg_search_scope :pg_search,
                  against: %W[email name short_bio about],
                  using: { tsearch: { dictionary: "russian" } }
  multisearchable against: %W[email name short_bio about]

  acts_as_taggable_on :skills, :interests
  acts_as_voter
  acts_as_votable
  devise :database_authenticatable, :rememberable, :trackable, :omniauthable,
    :lastseenable, omniauth_providers: [:facebook, :google_oauth2, :vkontakte]

  has_one :contact, dependent: :destroy
  has_many :listings, dependent: :destroy
  has_many :questions
  has_many :answers
  has_many :reviews
  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :experiences, dependent: :destroy
  has_many :images, class_name: "Picture", dependent: :destroy
  has_many :partners
  has_many :karmas

  validates :email, uniqueness: true, allow_nil: true
  validates :name, presence: true

  after_create :create_contact
  after_create :create_first_karma
  after_create :notify

  scope :week, -> { where("created_at > ?", Date.today.at_beginning_of_week) }
  scope :today, -> { where("created_at > ?", Date.today) }

  def self.with_parthers(kind = "side")
    joins(:partners)
      .where(partners: { active: true, kind: kind })
      .order("partners.impressions_count")
      .pluck(:id)
      .uniq
  end

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

  def member?
    admin? || %w[editor].include?(role)
  end

  private

  def notify
    SlackNotifierJob.perform_async(id, "User")
  end

  def create_first_karma
    return if Rails.env.test?
    Karma.create(user_id: self.id,
                giver_id: 1,
                karmable_type: "User",
                karmable_id: self.id,
                kind: "created")
  end
end
