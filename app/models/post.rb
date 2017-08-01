class Post < ApplicationRecord
  acts_as_taggable
  include Filterable
  include Commentable
  include MyFriendlyId

  belongs_to :user

  delegate :avatar, :name_to_show, to: :user

  has_one :action, as: :actionable, dependent: :destroy
  has_many :pictures, as: :imageable, dependent: :destroy

  validates :title, presence: true
  validates_presence_of :text
  validates_presence_of :tag_list

  after_create :create_action
  after_save :update_cached_tags

  def show_url
    Rails.application.routes.url_helpers.post_url(self)
  end

  def side_posts
    self.class.tagged_with(tag_list).order(created_at: :desc).take(8)
  end

  private

  def update_cached_tags
    update_column(:cached_tags, tags.pluck(:name).join(","))
  end
end
