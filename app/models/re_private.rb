class RePrivate < ActiveRecord::Base
  acts_as_mappable
  acts_as_commentable
  include Filterable
  include ViewHelpers
  include Tokenable

  validates :rooms, presence: true
  validates :duration, presence: true
  validates :post_type, presence: true
  validates :state_id, presence: true
  validates :city_id, presence: true
  validates :user_id, presence: true
  validates_with SourceValidator

  belongs_to :user
  belongs_to :state
  belongs_to :city
  has_many :pictures, as: :imageable, dependent: :destroy
  has_many :favorites, as: :favorable, dependent: :destroy
  has_one :entry, as: :enterable, dependent: :destroy
  has_many :subscriptions, as: :subscribable, dependent: :destroy

  def title
    street
  end

  def edit_link
    url_helpers.edit_dashboard_re_private_path(self)
  end

  def edit_url_with_token
    url_helpers.edit_dashboard_re_private_url(self, token: token)
  end

  def show_url
    url_helpers.re_private_url(self)
  end
end
