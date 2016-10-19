class Comment < ActiveRecord::Base
  belongs_to :commentable, polymorphic: true, touch: true
  belongs_to :user
  belongs_to :parent, class_name: "Comment", foreign_key: "parent_id"
  has_many :children, class_name: "Comment", foreign_key: "parent_id"
  validates :text, presence: true
  validates :user_id, presence: true

  delegate :show_url, to: :commentable
  delegate :title, to: :commentable
  delegate :logo, to: :user

  def emails
    subscribers.reject(&:online?).map(&:email)
  end

  def subscribers
    subscribers = []
    subscribers << commentable.user if commentable.user
    subscribers << parent.user if parent
    subscribers
  end
end
