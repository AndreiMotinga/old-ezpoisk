class ReCommercial < ActiveRecord::Base
  acts_as_mappable
  acts_as_commentable
  include Filterable
  include ViewHelpers

  validates :post_type, presence: true
  validates :price, presence: true
  validates :category, presence: true
  validates :state_id, presence: true
  validates :city_id, presence: true
  validates :street, presence: true
  validates :user_id, presence: true

  belongs_to :user
  belongs_to :state
  belongs_to :city
  has_many :pictures, as: :imageable, dependent: :destroy
  has_many :favorites, as: :favorable, dependent: :destroy
  has_one :entry, as: :enterable, dependent: :destroy

  def title
    street
  end

  def edit_link
    url_helpers.edit_dashboard_re_commercial_path(self)
  end

  def show_url
    url_helpers.re_commercial_url(self)
  end
end
