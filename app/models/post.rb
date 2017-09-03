# frozen_string_literal: true

class Post < ApplicationRecord
  acts_as_taggable
  acts_as_votable
  include Filterable
  include Commentable
  include MyFriendlyId
  include Impressionable
  include Karmable
  include ArticleExportable

  belongs_to :user

  delegate :avatar, :name, to: :user

  has_one :action, as: :actionable, dependent: :destroy
  has_many :pictures, as: :imageable, dependent: :destroy

  validates :title, presence: true
  validates_presence_of :text
  validates_presence_of :tag_list

  after_create :create_action
  after_create :export
  before_save :update_logo
  after_save :update_cached_tags

  scope :published, -> { where("published_at < ?", Time.zone.now) }

  def score
    get_upvotes.count - get_downvotes.count
  end

  def unpublished?
    published_at > Time.zone.now
  end

  def show_url
    Rails.application.routes.url_helpers.post_url(self)
  end

  def related_posts(n, offset = 0)
    Post.where.not(id: id)
        .older(created_at)
        .tagged_with(tag_list, any: true)
        .order(created_at: :desc)
        .offset(offset)
        .take(n)
  end

  def related_answers(n)
    Answer.tagged_with(tag_list, any: true).order(created_at: :desc).take(n)
  end

  private

  def update_cached_tags
    update_column(:cached_tags, tags.pluck(:name).join(","))
  end

  def update_logo
    img = Nokogiri::HTML(text).xpath("//img").first
    self.logo_url = img.attr("src") if img
  end

  def export
    ArticleExporterJob.perform_at(published_at, "Post", id)
  end
end
