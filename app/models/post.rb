class Post < ActiveRecord::Base
  validates :title, presence: true, length: { maximum: 90, minimum: 5 }
  validates :body, presence: true
  validates :category, presence: true


  belongs_to :user
  has_many :comments, dependent: :destroy

  has_attached_file :logo,
                    styles: { thumb: "300x150", large: "900x600" },
                    default_url: "community.jpg"
  validates_attachment_content_type :logo, content_type: /\Aimage\/.*\Z/
  # todo uncommnet and test
  # validates_attachment_presence :logo

  default_scope { order("created_at desc") }
  # paginates_per 10

  def self.by_category(category)
    where("LOWER(category) LIKE ?", "%#{category.mb_chars.downcase}%")
  end
end
