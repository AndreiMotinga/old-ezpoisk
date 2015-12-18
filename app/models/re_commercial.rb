class ReCommercial < ActiveRecord::Base
  # include Filterable

  # after_save :set_geo_attributes

  validates :price, presence: true
  validates :post_type, presence: true
  validates :state_id, presence: true
  validates :city_id, presence: true
  validates :street, presence: true
  validates :user, presence: true

  belongs_to :user
  belongs_to :picture # logo
  has_many :pictures, as: :imageable

  scope :active, -> { where(active: true) }
  scope :state_id, ->(id) { where(state_id: id) }
  scope :city_ids, -> (ids) { where(city_id: ids.split(',')) }
  scope :postType, -> (t) { where(post_type: t) }
  scope :min_space, -> (n) { where("space > ?", n.to_i - 1) }
  scope :min_price, -> (n) { where("price > ?", n.to_i - 1) }
  scope :max_price, -> (n) { where("price < ?", n.to_i + 1) }
  scope :category, -> (c) { where(category: c) }

  def self.sort_posts(type, sort_order)
    type = ['price', 'space', 'updated_at'][type.to_i]
    sort_order = sort_order.to_b ? 'desc' : 'asc'
    order("#{type} #{sort_order}")
  end

  def set_geo_attributes
    if self.state_id_changed? || self.city_id_changed? || self.street_changed?
      SetLatLngZipJob.perform_async(self.id, self.class.to_s)
    end
  end
end
