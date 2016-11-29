class SourceValidator < ActiveModel::Validator
  def validate(record)
    return if has_source?(record)
    record.errors[:phone] << "Добавьте телефон, email, ссылку на vk или fb"
  end

  def has_source?(record)
    return true if record.email.present?
    return true if record.phone.present?
    return true if record.vk.present?
    return true if record.fb.present?
  end
end
