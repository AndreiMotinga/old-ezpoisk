class Sale < ActiveRecord::Base
  acts_as_mappable
  acts_as_commentable
  include Filterable
  include ListingHelpers
  include Tokenable
  include Cachable
  validates_with SourceValidator

  validates :title, presence: true, length: { maximum: 90, minimum: 5 }
  validates :category, presence: true
  validates :state_id, presence: true
  validates :city_id, presence: true

  belongs_to :state
  belongs_to :city
  belongs_to :user, optional: true
  has_many :pictures, as: :imageable, dependent: :destroy
  has_many :deactivations, as: :deactivatable, dependent: :destroy
  has_many :favorites, as: :favorable, dependent: :destroy
  has_many :subscriptions, as: :subscribable, dependent: :destroy
  has_one :entry, as: :enterable, dependent: :destroy

  def edit_link
    Rails.application.routes.url_helpers.edit_dashboard_sale_path(self)
  end

  def edit_url_with_token
    Rails.application.routes.url_helpers.edit_dashboard_sale_url(self, token: token)
  end

  def show_url
    Rails.application.routes.url_helpers.sale_url(self)
  end

  def similar
    Job.includes(:state, :city)
       .active
       .state_id(state_id)
       .city_id(city_id)
       .category(category)
       .older(created_at)
       .desc
       .limit(10)
  end
end
