class Picture < ActiveRecord::Base
  belongs_to :imageable, polymorphic: true

  delegate :logo, to: :imageable, prefix: true

  has_attached_file :image, styles: { medium: "x163>", large: "x450" }
  validates_attachment_content_type :image, content_type: %r{\Aimage\/.*\Z}
  validates_attachment_file_name :image, matches: [/png\Z/i, /jpe?g\Z/i]
  validates_with AttachmentSizeValidator,
                 attributes: :image,
                 less_than: 5.megabytes
end
