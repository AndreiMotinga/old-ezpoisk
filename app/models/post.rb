class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :picture # logo

  default_scope { order("created_at desc") }
  # paginates_per 10

  validates :title, presence: true, length: { maximum: 90, minimum: 5 }
  validates :body, presence: true
  validates :category, presence: true

  scope :news, -> { where(category: "news") }
end
