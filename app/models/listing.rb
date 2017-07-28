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
  has_one :action, as: :actionable, dependent: :destroy

  validates_presence_of :user
  validates_presence_of :state
  validates_presence_of :city
  validates_with SourceValidator
  validates :title, presence: true, length: { minimum: 5, maximum: 70 }
  validates_presence_of :kind
  validates_presence_of :category
  validates_presence_of :subcategory
  validates :text, presence: true, length: { minimum: 10 }

  after_create :create_action
  after_create :notify_slack

  # todo remove deactivate
  def self.to_deactivate
    where.not(kind: "services")
         .where("active = ? AND updated_at < ?", true, 30.days.ago)
  end

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

  def re?
    kind == "недвижимость"
  end

  private

  def notify_slack
    SlackNotifierJob.perform_async(id, "Listing")
    GeocodeJob.perform_async(id, "Listing")
  end
end
