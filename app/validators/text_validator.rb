class TextValidator < ActiveModel::Validator
  def validate(record)
    if already_exists?(record)
      record.errors[:text] << "Объявление с таким тесктом было добавлено недавно"
    end
  end

  def already_exists?(record)
    old = record.class.where(text: record.text).last
    return unless old
    return if old.created_at < 2.days.ago
    true
  end
end
