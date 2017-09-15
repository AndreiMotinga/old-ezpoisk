# frozen_string_literal: true

# Listing represents all the classifieds
class Listing < ApplicationRecord
  include Filterable
  include Tokenable
  include Commentable
  include Impressionable
  include Mappable
  acts_as_mappable
  acts_as_taggable

  include PgSearch
  pg_search_scope :pg_search,
                  against: [:title, :text],
                  using: { tsearch: { dictionary: "russian" } }
  multisearchable against: [:title, :text]

  belongs_to :user
  belongs_to :state
  belongs_to :city
  has_many :pictures, as: :imageable, dependent: :destroy
  has_one :action, as: :actionable, dependent: :destroy

  validates_presence_of :user
  validates_presence_of :state
  validates_presence_of :city
  validates_with SourceValidator
  # validates :title, presence: true, length: { minimum: 5, maximum: 70 }
  validates_presence_of :kind
  validates :category, presence: true, if: Proc.new { |l| KINDS.include?(l.kind) }
  validates_presence_of :subcategory, if: Proc.new { |l| KINDS.include?(l.kind) }
  # validates :text, presence: true, length: { minimum: 10 }

  before_save :ensure_title
  before_save :format_site
  before_save :set_tags
  # after_create :create_action, if: Proc.new { |l| RU_KINDS.keys.include?(l.kind) }
  after_create :export

  def logo_url(style = :medium)
    return logo.image.url(style) if logo.present?
    "https://s3.amazonaws.com/ezpoisk/missing.png"
  end

  def logo
    pictures.where(logo: true).first
  end

  def unset_logo
    return unless logo
    logo.update_attribute(:logo, false)
  end

  def contact_email
    return email if email.present?
    user.email
  end

  def clear_phone!
    return unless self.phone.present?
    cleared = self.phone.split(",").map { |num| num.gsub(/\D/, "") }.join(",")
    self.update_attribute(:phone, cleared)
  end

  def show_url
    Rails.application.routes.url_helpers.listing_url(self)
  end

  def edit_url_with_token
    Rails.application.routes.url_helpers
                            .edit_listing_url(self, token: token)
  end

  def siblings
    return Listing.none if user.admin?
    user.listings.where(kind: kind).where.not(id: id).includes(:state, :city)
  end

  def answers(n = 8)
    order = "case when logo_url is null then -1 else 1 end desc"
    Answer.tagged_with(tag_list, any: true).order(order).limit(n)
  end

  def listing?
    RU_KINDS.keys.include? kind
  end

  def article?; end

  def city_slug
    return "new-york" if state_id == 32
    return "miami" if state_id == 9
    city.slug
  end

  def page_keywords
    { state: state.slug,
      city: city.slug,
      tags: tag_list }
  end

  # TODO: remove
  def self.update_services
    where(kind: "услуги", active: false).find_each do |l|
      next if l.street.present?
      next unless l.lat.present? && l.lng.present?
      res = Geokit::Geocoders::GoogleGeocoder.reverse_geocode [l.lat, l.lng].join(",")
      state_id = State.find_by_abbr(res.state)&.id || State.create(abbr: res.state).id
      city_id = City.find_by_name(res.city)&.id || City.create(state_id: state_id, name: res.city, slug: res.city.parameterize).id

      l.state_id = state_id || create_state
      l.city_id = city_id if city_id
      l.zip = res.zip

      link = Link.find_by_title(l.title)
      l.street = ActionController::Base.helpers.strip_tags(link.address.match(/<p>.*</)&.to_s)

      l.save
    end
  end

  private

  def ensure_title
    return if title.present?
    self.title = Media::Title.of(text)
  end

  def format_site
    return unless site.present?
    self.site = site.prepend("http://") unless site.match(/http/)
  end

  def set_tags
    return unless subcategory.present?
    subs = subcategory.split("--")
    self.tag_list = [kind, category, subs, state.slug, city.slug].flatten
  end

  def export
    ListingExporterJob.perform_in(1.hour, id)
  end
end
