class Post < ApplicationRecord
  include Filterable
  belongs_to :user

  delegate :avatar, :name_to_show, to: :user

  has_one :action, as: :actionable, dependent: :destroy

  after_create :create_action

  def show_url
    Rails.application.routes.url_helpers.post_url(self)
  end
end
