class Review < ApplicationRecord
  acts_as_taggable # homepage entry taggings include
  belongs_to :service, touch: true
  belongs_to :user
  has_one :entry, as: :enterable, dependent: :destroy

  validates :rating, presence: true
  validates :text, presence: true
  validates :service_id, presence: true
  validates :user_id, presence: true

  def show_url
    Rails.application.routes.url_helpers.service_url(service)
  end
end
