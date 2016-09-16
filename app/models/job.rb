class Job < ActiveRecord::Base
  acts_as_taggable
  acts_as_mappable
  acts_as_commentable
  include MyFriendlyId
  include Filterable
  include ViewHelpers
  include Tokenable

  validates :title, presence: true, length: { maximum: 90 }
  validates :text, presence: true
  validates :state_id, presence: true
  validates :city_id, presence: true
  validates_with SourceValidator

  belongs_to :state
  belongs_to :city
  belongs_to :user, optional: true

  has_many :favorites, as: :favorable, dependent: :destroy
  has_many :subscriptions, as: :subscribable, dependent: :destroy
  has_one :entry, as: :enterable, dependent: :destroy

  has_attached_file :logo, styles: { large: "755x425>" }
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
    url_helpers.edit_dashboard_job_path(self)
  end

  def self.subcategory(subs)
    subs = subs.map{|s| "%#{s.strip}%"}
    where("subcategory ILIKE ANY ( array[?] )", subs)
  end

  def show_url
    url_helpers.job_url(self)
  end

  def edit_url_with_token
    url_helpers.edit_dashboard_job_url(self, token: token)
  end

  def self.taggings_list
    ActsAsTaggableOn::Tag.joins(:taggings)
                         .where("taggings.taggable_type = ?", "Job")
                         .uniq
  end
end
