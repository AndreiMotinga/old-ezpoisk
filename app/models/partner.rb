class Partner < ActiveRecord::Base
  belongs_to :user

  has_attached_file(:image,
                    default_url: "https://s3.amazonaws.com/ezpoisk/missing.png")
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
  validates_attachment_file_name :image, matches: [/png\Z/i, /jpe?g\Z/i]
  validates_with AttachmentSizeValidator, attributes: :image, less_than: 1.megabyte
  validates :image, presence: true
  validates :image, dimensions: {}

  validates :title, presence: true
  validates :image, presence: true
  validates :page, presence: true
  validates_with PositionValidator

  scope :by_position, -> (pos) { where(position: pos) }
  scope :by_page, -> (page) { where(page: page) }

  def self.active
    where("start_date < ? AND active_until > ?", Date.tomorrow, Date.today)
  end

  def self.current(page, position)
    by_page(page)
      .by_position(position)
      .active
      .first
  end

  def available_start_date
    self.class
        .by_page(page)
        .by_position(position)
        .where.not(active_until: nil)
        .order("active_until desc").first
        .try(:active_until) || Date.today
  end

  def activate(weeks_prm)
    num_of_weeks = weeks_prm.to_i
    self.start_date = available_start_date
    self.active_until = available_start_date + num_of_weeks.weeks
    self.amount = amount_to_pay(num_of_weeks)
    save
  end

  def amount_to_pay(weeks, user = nil)
    return 100 if user.try(:admin?)
    case weeks
    when 1
      # price * num_of_weeks* days  * 100 cents
      14 * 1 * 7 * 100
    when 2
      11 * 2 * 7 * 100
    when 4
      9 * 4 * 7 * 100
    end
  end

  def active?
    active_until.try(:future?)
  end
end
