class Post < ActiveRecord::Base
  validates :title, presence: true, length: { maximum: 90, minimum: 5 }
  validates_uniqueness_of :title
  validates :category, presence: true
  validates :text, presence: true

  belongs_to :user
  has_many :comments, dependent: :destroy

  has_attached_file :image,
                    styles: { small: "165x120#", medium: "600x337#"},
                    :s3_protocol => :https,
                    default_url: "missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  scope :desc, -> { order("created_at desc") }
  scope :for_homepage, -> { where(show_on_homepage: true) }
  scope :main, -> { where(main: true).last }
  scope :main_posts, -> { where(main: true).order("updated_at desc") }

  def self.by_category(category)
    where("LOWER(category) LIKE ?", "%#{category.mb_chars.downcase}%")
  end

  def self.by_subcategory(subcategory)
   where("LOWER(subcategory) LIKE ?", "%#{subcategory.mb_chars.downcase}%")
  end

  def logo_url(style = :medium)
    return logo unless main?
    image.url(style)
  end
end
