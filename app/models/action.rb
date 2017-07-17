class Action < ApplicationRecord
  belongs_to :actionable, polymorphic: true

  delegate :user, :text, :show_url, :created_at, to: :actionable

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
end
