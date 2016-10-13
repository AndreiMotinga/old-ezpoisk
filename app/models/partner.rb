class Partner < ActiveRecord::Base
  POSITIONS = %w(left right).freeze
  belongs_to :user

  has_attached_file :image, styles: { thumb: "100x50",
                                      left: "200x100#", right: "300x250#" }
  validates_attachment_content_type :image, content_type: %r{\Aimage\/.*\Z}
  validates_attachment_file_name :image, matches: [/png\Z/i, /jpe?g\Z/i]
  validates_with AttachmentSizeValidator,
                 attributes: :image,
                 less_than: 1.megabyte
  validates :title, presence: true, length: { maximum: 45 }
  validates :text, presence: true, length: { maximum: 45 }
  validates :image, presence: true
  validates :phone, presence: true
  validates :budget, presence: true
  validates :email, presence: true

  scope :approved, -> { where(approved: true) }

  def self.random(position, num)
    approved
      .where(position: position)
      .order("featured desc")
      .limit(num)
      .order("RANDOM()")
  end

  def redirect_url
    url.match(/http/).present? ? url : "http://#{url}"
  end

  def show_url
    ActionMailer::Base.default_url_options[:host] + "/teacup/partners/#{id}/edit"
  end
end
