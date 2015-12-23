class RePrivate < ActiveRecord::Base
  include Filterable

  validates :price, presence: true,
                    numericality: { greater_than_or_equal_to: 0 }
  validates :post_type, presence: true
  validates :state_id, presence: true
  validates :city_id, presence: true
  validates :street, presence: true
  validates :user_id, presence: true

  belongs_to :user
  belongs_to :state
  belongs_to :city
  has_many :pictures, as: :imageable, dependent: :destroy

  scope :active, -> { where(active: true) }
  scope :state_id, ->(id) { where(state_id: id) }
  scope :city_ids, -> (ids) { where(city_id: ids) }
  scope :fee, -> (fee) { where(fee: fee) }
  scope :post_type, -> (type) { where(post_type: type) }
  scope :duration, -> (type) { where(duration: type) }
  scope :rooms, -> (num) { where("rooms >= ?", num.to_i) }
  scope :baths, -> (num) { where("baths >= ?", num.to_i) }
  scope :space, -> (num) { where("space >= ?", num.to_i) }
  scope :min_price, -> (num) { where("price >= ?", num.to_i) }
  scope :max_price, -> (num) { where("price <= ?", num.to_i) }

  def self.sort(type)
    order type
  end

  def logo
    pictures.find_by_logo(true)
  end

  def logo_url(style)
    if logo
      logo.image.url(style)
    else
      "missing.png"
    end
  end

  def show_description
    description.blank? ? I18n.t(:no_description) : description
  end

  def address
    "#{street}, #{city.name} #{state.name}, #{zip}"
  end

  def map_marker
    Gmaps4rails.build_markers(self) do |re_private, marker|
      marker.lat re_private.latitude
      marker.lng re_private.longitude
      marker.infowindow re_private.infowindow
    end
  end

  def infowindow
    "<a href='http://maps.google.com/?q=#{address}' target='blank'>#{address}</a>"
  end

end
