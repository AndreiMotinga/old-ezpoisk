# frozen_string_literal: true
# Listing represents all the classifieds
class Listing < ApplicationRecord
  include Filterable
  include ListingHelpers
  include Tokenable
  include Cachable
  include Commentable
  acts_as_mappable

  belongs_to :user
  belongs_to :state
  belongs_to :city
  has_many :pictures, as: :imageable, dependent: :destroy
  has_many :favorites, as: :favorable, dependent: :destroy
  has_many :deactivations, as: :deactivatable, dependent: :destroy

  validates_presence_of :user
  validates_presence_of :state
  validates_presence_of :city
  # validates_presence_of :
  validates_with SourceValidator

  def edit_link
    Rails.application.routes.url_helpers.edit_dashboard_listing_path(self)
  end

  def show_url
    Rails.application.routes.url_helpers.listing_url(self)
  end

  def edit_url_with_token
    Rails.application.routes.url_helpers
                            .edit_dashboard_listing_url(self, token: token)
  end
end
