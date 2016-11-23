# todo remove
class Job < ActiveRecord::Base
  CATEGORIES = %w(wanted seeking).freeze
  SUBCATEGORIES = %w(autoservices drivers temporary formen journalism art
    computers medical real-estate nannies education office security factories
    advertisement restourants beauty-salons escort sports
    construction sales management finances-taxes other).freeze

  acts_as_taggable
  acts_as_mappable
  include Filterable
  include ListingHelpers
  include Tokenable
  include Cachable
  include Commentable

  validates :title, presence: true, length: { maximum: 90 }
  validates :text, presence: true, length: { minimum: 10 }
  validates :state_id, presence: true
  validates :city_id, presence: true
  validates_with SourceValidator

  belongs_to :state
  belongs_to :city
  belongs_to :user, optional: true

  has_many :favorites, as: :favorable, dependent: :destroy
  has_many :deactivations, as: :deactivatable, dependent: :destroy

  has_attached_file :logo, styles: { large: "755x425>" },
                    default: "https://s3.amazonaws.com/ezpoisk/ezpoisk.png"
  validates_attachment_content_type :logo, content_type: %r{\Aimage\/.*\Z}
  validates_with(
    AttachmentSizeValidator,
    attributes: :logo,
    less_than: 1.megabytes
  )

  scope :state_id, ->(id) { where(state_id: id).or(Job.where(remote: true)) }
  scope :city_id, -> (id) { where(city_id: id).or(Job.where(remote: true)) }

  scope(:geo_scope, lambda do |geo_scope|
    return if geo_scope[:within].blank? || geo_scope[:origin].blank?
    within(geo_scope[:within], origin: geo_scope[:origin])
      .or(Job.where(remote: true))
  end)

  def edit_link
    Rails.application.routes.url_helpers.edit_dashboard_job_path(self)
  end

  def self.subcategory(subs)
    subs = subs.map{|s| "%#{s.strip}%"}
    where("subcategory ILIKE ANY ( array[?] )", subs)
  end

  def show_url
    Rails.application.routes.url_helpers.job_url(self)
  end

  def edit_url_with_token
    Rails.application.routes.url_helpers
                            .edit_dashboard_job_url(self, token: token)
  end

  def self.taggings_list
    ActsAsTaggableOn::Tag.joins(:taggings)
                         .where("taggings.taggable_type = ?", "Job")
                         .order("name")
                         .distinct
  end

  def similar
    Job.includes(:state, :city)
       .active
       .state_id(state_id)
       .city_id(city_id)
       .post_type(post_type)
       .category(category)
       .older(created_at)
       .desc
       .limit(10)
  end

  def update_cached_tags
    update_column(:cached_tags, tags.pluck(:name).join(","))
  end
end
