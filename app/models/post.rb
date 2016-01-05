class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments, dependent: :destroy

  default_scope { order("created_at desc") }
  # paginates_per 10

  validates :title, presence: true, length: { maximum: 90, minimum: 5 }
  validates :body, presence: true
  validates :category, presence: true

  has_attached_file :logo,
                    styles: { thumb: "300x150", large: "900x600" },
                    default_url: "community.jpg"
  validates_attachment_content_type :logo, content_type: /\Aimage\/.*\Z/
  # validates_attachment_presence :logo
end
