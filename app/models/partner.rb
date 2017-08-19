# frozen_string_literal: true

class Partner < ApplicationRecord
  include Impressionable
  belongs_to :user
  belongs_to :state
  belongs_to :city

  validates :title, presence: true, length: { maximum: 45 }
  validates :final_url, presence: true
  validates :headline, presence: true, length: { maximum: 45 }

  has_attached_file :image, styles: { medium: "300x200#" }
  validates_attachment_content_type :image, content_type: %r{\Aimage\/.*\Z}
  validates_attachment_file_name :image, matches: [/png\Z/i, /jpe?g\Z/i]
  validates_with AttachmentSizeValidator,
                 attributes: :image,
                 less_than: 1.megabyte

  scope :approved, -> { where({}) }

  def self.get(num)
    approved.limit(num).order("RANDOM()")
  end
end
