class Post < ActiveRecord::Base
  validates :title, presence: true, length: { maximum: 90, minimum: 5 }
  validates_uniqueness_of :title
  validates :category, presence: true
  validates :description, presence: true

  belongs_to :user
  has_many :comments, dependent: :destroy

  scope :desc, -> { order("created_at desc") }
  scope :important, -> { where(important: true) }
  scope :for_homepage, -> { where(show_on_homepage: true) }
  scope :main, -> { where(main: true).order(:updated_at).last }

  def self.by_category(category)
    where("LOWER(category) LIKE ?", "%#{category.mb_chars.downcase}%")
  end
   def self.by_subcategory(subcategory)
    where("LOWER(subcategory) LIKE ?", "%#{subcategory.mb_chars.downcase}%")
   end
end
