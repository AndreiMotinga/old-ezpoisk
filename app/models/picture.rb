class Picture < ActiveRecord::Base
  belongs_to :imageable, polymorphic: true

  has_attached_file :image,
                    styles: { thumb: "100x100>", medium: "300x170>", large: "900x510>" },
                    :s3_protocol => :https,
                    default_url: "missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
  validates_attachment_file_name :image, matches: [/png\Z/, /jpe?g\Z/]
  validates_with AttachmentSizeValidator, attributes: :image, less_than: 10.megabytes
end
