class Post < ActiveRecord::Base
  belongs_to :user

  default_scope { order("created_at desc") }
  # paginates_per 10

  validates :title, presence: true, length: { maximum: 90, minimum: 5 }
  validates :body, presence: true
  validates :category, presence: true

  scope :news, -> { where(category: "news") }

  has_attached_file :logo,
                    styles: { large: "900x600" },
                    default_url: "missing.png"
  validates_attachment_content_type :logo, content_type: /\Aimage\/.*\Z/
end
