class Answer < ActiveRecord::Base
  acts_as_taggable
  include Filterable
  include MyFriendlyId
  acts_as_votable
  acts_as_commentable
  belongs_to :user
  belongs_to :question

  delegate :name_to_show, to: :user

  scope :by_score, -> { all.sort_by(&:score).reverse }
  scope :today, -> { where("created_at > ?", Time.zone.yesterday) }

  def self.this_week
    where("created_at > ?", Date.current.at_beginning_of_week).count
  end

  def score
    get_upvotes.count - get_downvotes.count
  end

  def show_url
    Rails.application.routes.url_helpers.answer_url(self)
  end

  def avatar
    user.avatar(:thumb)
  end

  def side_posts
    @posts = Post.visible.last(9)
  end
end
