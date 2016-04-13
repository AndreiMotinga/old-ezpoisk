class Partner < ActiveRecord::Base
  acts_as_taggable_on :pages
  belongs_to :user
  belongs_to :state
  has_many :partner_cities
  has_many :cities, through: :partner_cities

  has_attached_file(:image) # todo replace this
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
  validates_attachment_file_name :image, matches: [/png\Z/i, /jpe?g\Z/i]
  validates_with AttachmentSizeValidator, attributes: :image, less_than: 1.megabyte

  validates :title, presence: true
  validates :state_id, presence: true

  scope :active, -> { where(active: true) }
  scope :by_state, ->(id) { where(state_id: id) }
  scope :with_balance, -> { where("current_balance < budget") }
  scope :by_bid, -> { order("bid desc") }
  scope :by_position, -> (pos) { where(position: pos) }

  def self.by_city(city_id)
    includes(:partner_cities).where(partner_cities: {city_id: city_id})
  end

  def self.filter(position, page, state_id, city_id)
    active
      .by_state(state_id)
      .by_city(city_id)
      .with_balance
      .by_position(position)
      .tagged_with(page)
      .by_bid
  end

  def avg_price
    return unless impressions_count > 0
    current_balance / impressions_count
  end
end
