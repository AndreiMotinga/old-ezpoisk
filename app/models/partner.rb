# frozen_string_literal: true

class Partner < ApplicationRecord
  acts_as_taggable

  include Impressionable
  belongs_to :user
  belongs_to :state
  belongs_to :city

  validates :title, presence: true
  validates :final_url, presence: true
  validates :headline, presence: true, length: { maximum: 50 }
  validates :subline, presence: true, length: { maximum: 50 }
  validates :text, presence: true, length: { maximum: 160 }

  has_attached_file :image, styles: { medium: "300x200#" }
  validates_attachment_content_type :image, content_type: %r{\Aimage\/.*\Z}
  validates_attachment_file_name :image, matches: [/png\Z/i, /jpe?g\Z/i]
  validates_with AttachmentSizeValidator,
                 attributes: :image,
                 less_than: 1.megabyte

  scope :active, -> { where(active: true) }
  scope :by_state, -> (slug) { where(state_id: [nil, State.find_by_slug(slug).try(:id)]) }
  scope :by_city, -> (slug) { where(city_id: [nil, City.find_by_slug(slug).try(:id)]) }
  scope :ez, -> { where(final_url: "ezpoisk.com/реклама").order("random ()") }

  def self.by_tags(tags)
    tagged_with(tags, any: true)
  end

  def self.side(limit = 3)
    items = User.with_parthers.map do |id|
      Partner.where(user_id: id, kind: "side").order(:impressions_count).first
    end
    limit == 1 ? items.first : items[0..limit-1].shuffle
  end

  def self.inline(limit = 1, opts = {})
    items = User.with_parthers("inline").map do |id|
      Partner.active
             .by_state(opts[:state])
             .by_city(opts[:city])
             .by_tags(opts[:tags])
             .where(user_id: id)
             .order(:impressions_count).first
    end.compact
    # TODO: spec that returning array doesn't include nils
    items = items[0..limit - 1].shuffle.compact
    items.blank? ? ez : items
  end
end
