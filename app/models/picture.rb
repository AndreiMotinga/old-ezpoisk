class Picture < ActiveRecord::Base
  belongs_to :imageable, polymorphic: true

  has_attached_file(:image,
                    styles: { medium: "300x170#", large: "x450" },
                    default_url: "missing.png")
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
  validates_attachment_file_name :image, matches: [/png\Z/i, /jpe?g\Z/i]
  validates_with AttachmentSizeValidator, attributes: :image, less_than: 10.megabytes
end
