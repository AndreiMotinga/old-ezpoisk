class Post < ActiveRecord::Base
  validates :title, presence: true, length: { maximum: 90, minimum: 5 }
  validates_uniqueness_of :title
  validates :category, presence: true
  validates :logo, presence: true
  validates :description, presence: true

  belongs_to :user
  has_many :comments, dependent: :destroy

  def self.by_category(category)
    where("LOWER(category) LIKE ?", "%#{category.mb_chars.downcase}%")
  end

  def self.content_for_right_sidebar(size)
    where(important: true).limit(size)
  end

  def self.main
    where(important: true).first
  end
end
