class Post < ApplicationRecord
  acts_as_taggable
  include Filterable
  include Commentable
  include MyFriendlyId

  belongs_to :user

  delegate :avatar, :name, to: :user

  has_one :action, as: :actionable, dependent: :destroy
  has_many :pictures, as: :imageable, dependent: :destroy

  validates :title, presence: true
  validates_presence_of :text
  validates_presence_of :tag_list

  after_create :create_action
  before_save :update_logo
  after_save :update_cached_tags

  scope :published, -> { where("published < ?", Time.zone.now) }

  def show_url
    Rails.application.routes.url_helpers.post_url(self)
  end

  def similar(n)
    Post.tagged_with(tag_list, any: true).order(created_at: :desc).take(n)
  end

  def similar_older(n)
    Post.tagged_with(tag_list, any: true).older(created_at).take(n)
  end

  private

  def update_cached_tags
    update_column(:cached_tags, tags.pluck(:name).join(","))
  end

  def update_logo
    img = Nokogiri::HTML(text).xpath("//img").first
    self.logo_url = img.attr("src") if img
  end
end
