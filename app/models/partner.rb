class Partner < ActiveRecord::Base
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

  def self.random(position, num)
    where(position: position)
      .limit(num)
      .order("RANDOM()")
  end

  def redirect_url
    url.match(/http/).present? ? url : "http://#{url}"
  end
end
