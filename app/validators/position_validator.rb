class PositionValidator < ActiveModel::Validator
  def validate(partner)
    if wrong_postition?(partner)
      partner.errors[:position] << "Не существует для #{partner.page}"
    end
  end

  def wrong_postition?(partner)
    return unless partner.page == "Домашняя"
    true if %w(Сбоку Внизу).include? partner.position
  end
end
