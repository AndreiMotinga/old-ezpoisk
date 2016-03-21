class Partner < ActiveRecord::Base
  belongs_to :user
  has_many :partner_pages
  has_many :pages, through: :partner_pages

  has_attached_file(:image) # todo replace this
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
  validates_attachment_file_name :image, matches: [/png\Z/i, /jpe?g\Z/i]
  validates_with AttachmentSizeValidator, attributes: :image, less_than: 1.megabyte

  validates :title, presence: true

  scope :active, -> { where(active: true) }
  scope :with_balance, -> { where("current_balance < budget") }
  scope :by_bid, -> { order("bid desc") }
  scope :by_position, -> (pos) { where(position: pos) }

  def self.filter(position, page)
    active.with_balance.by_position(position).by_page(page).by_bid
  end

  def self.by_page(page)
    includes(:pages)
      .where("pages.title LIKE ?", "%#{page}%")
      .references(:pages)
  end

  def avg_price
    return unless impressions_count > 0
    current_balance / impressions_count
  end
end
