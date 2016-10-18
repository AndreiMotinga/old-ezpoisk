class Comment < ActiveRecord::Base
  belongs_to :commentable, polymorphic: true, touch: true
  belongs_to :user
  validates :text, presence: true
  validates :user_id, presence: true

  def logo
    return "default-avatar" unless user
    user.avatar(:thumb)
  end
end
