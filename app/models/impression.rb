# frozen_string_literal: true

class Impression < ApplicationRecord
  belongs_to :impressionable, polymorphic: true, counter_cache: true
  belongs_to :user

  before_save :unescape_uri

  scope :show, -> { where(kind: "show") }
  scope :visit, -> { where(kind: "visit") }
  scope :by_ip, -> { group(:ip_address).count }

  private

  def unescape_uri
    self.referrer = URI.unescape(referrer) if referrer
  end
end
