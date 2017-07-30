class Comment < ActiveRecord::Base
  belongs_to :commentable, polymorphic: true, touch: true
  belongs_to :user
  belongs_to :parent, class_name: "Comment", foreign_key: "parent_id"
  has_many :children, class_name: "Comment", foreign_key: "parent_id"
  validates :text, presence: true
  validates :user_id, presence: true

  delegate :show_url, to: :commentable
  delegate :title, to: :commentable
  delegate :avatar, to: :user

  def self.popular
    where.not(commentable_type: "Listing")
      .where('created_at > ?', 4.hours.ago)
      .group(:commentable_type, :commentable_id)
      .order(:count).reverse_order.count
      .keys
      .first(5)
      .map {|rec| rec[0].constantize.find(rec[1]) }
  end

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
