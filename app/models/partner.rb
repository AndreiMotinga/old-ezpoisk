# frozen_string_literal: true

class Partner < ApplicationRecord
  acts_as_taggable

  include Impressionable
  belongs_to :user
  belongs_to :state
  belongs_to :city

  validates :title, presence: true, length: { maximum: 45 }
  validates :final_url, presence: true
  validates :headline, presence: true, length: { maximum: 45 }

  before_create :set_random_cached_ctr

  has_attached_file :image, styles: { medium: "300x200#" }
  validates_attachment_content_type :image, content_type: %r{\Aimage\/.*\Z}
  validates_attachment_file_name :image, matches: [/png\Z/i, /jpe?g\Z/i]
  validates_with AttachmentSizeValidator,
                 attributes: :image,
                 less_than: 1.megabyte

  scope :approved, -> { where({}) }
  scope :state, -> (slug) { where(state_id: [nil, State.find_by_slug(slug).try(:id)]) }
  scope :city, -> (slug) { where(city_id: [nil, City.find_by_slug(slug).try(:id)]) }

  def self.by_ctr
    # todo  figure out how to write it properly ( in one query? )
    top = select("user_id, max(cached_ctr)").group(:user_id)
    q = top.map { |p| "(user_id = '#{p.user_id}' AND cached_ctr = '#{p.max}')" }.join(" OR ")
    where(q)
  end

  def self.by_tags(tags)
    # todo  figure out how to write it properly
    empty = includes(:taggings).where(taggings: { id: nil }).pluck :id
    with_tags = tagged_with(tags, any: true).pluck :id
    where(id: empty + with_tags)
  end

  def self.get(limit: 3, state: nil, city: nil, tags: nil)
    tags = [tags].flatten # tags can be string or array of arrays
    items = approved
    items = items.state(state)
    items = items.city(city)
    items = items.by_tags(tags)
    items = items.by_ctr.limit(limit)
    limit == 1 ? items.first : items.to_a.shuffle
  end

  private

  def set_random_cached_ctr
    self.cached_ctr = rand / 10 unless cached_ctr
  end
end
