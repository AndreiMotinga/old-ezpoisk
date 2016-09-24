class Picture < ActiveRecord::Base
  belongs_to :imageable, polymorphic: true

  delegate :logo, to: :imageable, prefix: true

  has_attached_file :image, styles: { medium: "x120",
                                      thumbnail: "100x100#",
                                      large: "x450" }
  validates_attachment_content_type :image, content_type: %r{\Aimage\/.*\Z}
  validates_attachment_file_name :image, matches: [/png\Z/i, /jpe?g\Z/i]
  validates_with AttachmentSizeValidator,
                 attributes: :image,
                 less_than: 5.megabytes

  attr_reader :image_remote_url
  def image_remote_url=(url_value)
    if url_value.present?
      self.image = URI.parse(url_value)
      @image_remote_url = url_value
    end
  end
end
