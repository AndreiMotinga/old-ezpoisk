class Review < ApplicationRecord
  include Commentable
  acts_as_taggable # remove it?
  belongs_to :service, touch: true
  belongs_to :user

  validates :rating, presence: true
  validates :text, presence: true
  validates :service_id, presence: true
  validates :user_id, presence: true

  delegate :logo, to: :user

  def show_url
    Rails.application.routes.url_helpers.service_url(service)
  end
end
