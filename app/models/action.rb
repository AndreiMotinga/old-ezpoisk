class Action < ApplicationRecord
  belongs_to :actionable, polymorphic: true

  delegate :user, :text, :title, :show_url, :created_at, to: :actionable

  def kind
    case actionable.class.to_s
    when "Answer"
      "добавил(а) ответ"
    when "Listing"
      "добавил(а) объявление"
    when "Question"
      "задал(а) вопрос"
    end
  end

  def name
    return actionable.from_name if actionable.try(:from_name).present?
    "ez"
  end

  def name_url
    if actionable.try(:kind )== "Listing" && actionable.user_id == 1 # was imported
      return actionable.vk if actionable.vk.present?
      return actionable.fb if actionable.fb.present?
    end
    Rails.application.routes.url_helpers.profile_path(actionable.user)
  end

  def text_to_show
    return text if text.present?
    title
  end

  def slug
    user.slug unless actionable.user_id == 1
  end
end
