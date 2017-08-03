class Action < ApplicationRecord
  belongs_to :actionable, polymorphic: true

  delegate :user, :text, :title, :show_url, :created_at, to: :actionable

  def cached_tags
    return [] if actionable_type == "Listing"
    actionable.cached_tags
  end

  def name
    return actionable.from_name if actionable.try(:from_name).present?
    return actionable.user.name if actionable.user.name.present?
    ""
  end

  def name_url
    if actionable_type == "Listing" && actionable.user_id == 1 # was imported
      return actionable.vk if actionable.vk.present?
      return actionable.fb if actionable.fb.present?
    end
    Rails.application.routes.url_helpers.user_path(actionable.user)
  end

  def text_to_show
    return text if text.present?
    title
  end

  def short_bio
    user.short_bio unless actionable.user_id == 1
  end

  def image_url
    return user.avatar(:thumb) unless actionable.user_id == 1
    "https://s3.amazonaws.com/ezpoisk/default-avatar.png"
  end

  def display_name
    actionable.class.to_s
  end
end
