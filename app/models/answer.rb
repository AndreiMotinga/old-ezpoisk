class Answer < ActiveRecord::Base
  acts_as_taggable
  include Filterable
  include MyFriendlyId
  include Commentable
  acts_as_votable

  belongs_to :user
  belongs_to :question, touch: true
  belongs_to :state
  belongs_to :city
  has_one :action, as: :actionable, dependent: :destroy

  validates :title, presence: true
  validates :text, presence: true
  delegate :name, to: :user
  delegate :avatar, to: :user

  after_create :create_action

  def score
    get_upvotes.count - get_downvotes.count
  end

  def show_url
    Rails.application.routes.url_helpers.answer_url(self)
  end

  def edit_url_with_token
    Rails.application.routes.url_helpers.edit_answer_url(self)
  end

  # extract to concern
  def update_cached_tags
    update_column(:cached_tags, tags.pluck(:name).join(","))
  end

  def active
    true
  end
end
