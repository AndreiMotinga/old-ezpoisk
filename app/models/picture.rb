class Picture < ActiveRecord::Base
  belongs_to :imageable, polymorphic: true

  has_attached_file :image,
                    styles: { thumb: "100x100>", medium: "300x150", large: "900x600" },
                    default_url: "missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
  # validates_attachment_presence :image
end
