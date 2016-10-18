class Comment < ActiveRecord::Base
  belongs_to :commentable, polymorphic: true, touch: true
  belongs_to :user
  belongs_to :parent, class_name: "Comment", foreign_key: "parent_id"
  has_many :children, class_name: "Comment", foreign_key: "parent_id"
  validates :text, presence: true
  validates :user_id, presence: true

  delegate :show_url, to: :commentable

  # todo move to user and use delegate
  def logo
    user.avatar(:thumb)
  end
end
