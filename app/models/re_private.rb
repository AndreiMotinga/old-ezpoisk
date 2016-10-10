class RePrivate < ActiveRecord::Base
  CATEGORIES = %w(apartment office sales industry parking other).freeze
  TYPES = %w(leasing renting selling buying).freeze
  DURATION = %w(monthly weekly daily hourly).freeze
  ROOMS = %w(room bed studio 1-bebroom 2-bebroom 3-bebroom 4-bebroom
             5-bebroom 6-bebroom 7-bebroom 8-bebroom 9-bebroom).freeze

  acts_as_mappable
  acts_as_commentable
  include Filterable
  include ListingHelpers
  include Tokenable
  include Cachable

  validates :rooms, presence: true
  validates :duration, presence: true
  validates :post_type, presence: true
  validates :state_id, presence: true
  validates :city_id, presence: true
  validates_with SourceValidator

  belongs_to :user, optional: true
  belongs_to :state
  belongs_to :city
  has_many :pictures, as: :imageable, dependent: :destroy
  has_many :deactivations, as: :deactivatable, dependent: :destroy
  has_many :favorites, as: :favorable, dependent: :destroy
  has_one :entry, as: :enterable, dependent: :destroy
  has_many :subscriptions, as: :subscribable, dependent: :destroy

  alias_attribute :title, :street

  def edit_link
    Rails.application.routes.url_helpers.edit_dashboard_re_private_path(self)
  end

  def edit_url_with_token
    Rails.application.routes.url_helpers.edit_dashboard_re_private_url(self, token: token)
  end

  def show_url
    Rails.application.routes.url_helpers.re_private_url(self)
  end

  def temporary?
    post_type == "leasing" || post_type == "renting"
  end

  def similar
    RePrivate.includes(:state, :city)
             .active
             .state_id(state_id)
             .city_id(city_id)
             .post_type(post_type)
             .category(category)
             .duration(duration)
             .older(created_at)
             .desc
             .limit(10)
  end
end
