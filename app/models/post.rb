class Post < ActiveRecord::Base
  include MyFriendlyId
  include ViewHelpers
  validates :title, presence: true, length: { maximum: 90, minimum: 5 }
  validates :text, presence: true # , length: { maximum: 160, minimum: 100 }

  belongs_to :user
  has_many :favorites, as: :favorable, dependent: :destroy
  has_one :profile, through: :user
  delegate :avatar, to: :profile

  has_attached_file(:image,
                    styles: { small: ["158x99#"],
                              medium: ["585x329#", :jpg],
                              large: ["755x425#", :jpg] },
                    default_url: "https://s3.amazonaws.com/ezpoisk/missing.png")
  validates_attachment_content_type :image, content_type: %r{\Aimage\/.*\Z}
  attr_reader :image_remote_url
  def image_remote_url=(url_value)
    if url_value.present?
      self.image = URI.parse(url_value)
      @image_remote_url = url_value
    end
  end

  scope :desc, -> { order("created_at desc") }
  scope :visible, -> { where(visible: true) }
  scope :invisible, -> { where(visible: false) }
  scope :today, -> { where("created_at > ?", Time.zone.yesterday) }
  has_one :entry, as: :enterable, dependent: :destroy

  def self.by_keyword(keyword)
    return all if keyword.blank?
    keys = convert_keyword(keyword)
    query = "LOWER(title) ILIKE ANY (array[?]) OR LOWER(text) ILIKE ANY (array[?])"
    where(query, keys, keys)
  end

  def self.convert_keyword(keyword)
    keyword.gsub(/[^0-9a-zа-я ]/i, "")
           .split(" ")
           .map { |key| "%#{key.mb_chars.downcase}%" }
  end

  def logo_url(style = :medium)
    image.url(style)
  end

  def edit_link
    url_helpers.edit_dashboard_post_path(self)
  end

  def active?
    true
  end
end
