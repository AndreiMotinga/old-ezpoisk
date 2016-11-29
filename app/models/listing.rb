# frozen_string_literal: true
# Listing represents all the classifieds
class Listing < ApplicationRecord
  include Filterable
  include Tokenable
  include Commentable
  include Mappable
  acts_as_mappable

  belongs_to :user
  belongs_to :state
  belongs_to :city
  has_many :pictures, as: :imageable, dependent: :destroy

  validates_presence_of :user
  validates_presence_of :state
  validates_presence_of :city
  validates_with SourceValidator

  def logo_url
    return logo.image.url(:medium) if logo.present?
    "https://s3.amazonaws.com/ezpoisk/missing-small.png"
  end

  def logo
    pictures.where(logo: true).first
  end

  def unset_logo
    return unless logo
    logo.update_attribute(:logo, false)
  end

  def contact_email
    return user.email if user.present?
    return email if email.present?
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
                            .edit_dashboard_listing_url(self, token: token)
  end

  def re?
    kind == "real-estate"
  end
end
