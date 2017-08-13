class Impression < ApplicationRecord
  belongs_to :impressionable, polymorphic: true
  belongs_to :user

  before_save :unescape_uri

  scope :show, -> { where(kind: "show") }
  scope :visit, -> { where(kind: "visit") }
  scope :uniq_count, -> { group(:ip_address).count }

  private

  def unescape_uri
    self.referrer = URI.unescape(referrer) if referrer
  end
end
