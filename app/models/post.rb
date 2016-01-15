class Post < ActiveRecord::Base
  default_scope { order("created_at desc") }

  validates :title, presence: true, length: { maximum: 90, minimum: 5 }
  validates :body, presence: true
  validates :category, presence: true
  validates :logo, presence: true

  belongs_to :user
  has_many :comments, dependent: :destroy

  def self.by_category(category)
    where("LOWER(category) LIKE ?", "%#{category.mb_chars.downcase}%")
  end

  def self.content_for_right_sidebar
    where(important: true).limit(10)
  end
end
