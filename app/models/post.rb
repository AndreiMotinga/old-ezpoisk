class Post < ActiveRecord::Base
  default_scope { order("created_at desc") }

  validates :title, presence: true, length: { maximum: 90, minimum: 5 }
  validates :body, presence: true
  validates :category, presence: true

  belongs_to :user
  has_many :comments, dependent: :destroy

  # todo uncommnet and test
  # validates_attachment_presence :logo


  def self.by_category(category)
    where("LOWER(category) LIKE ?", "%#{category.mb_chars.downcase}%")
  end
end
