class SocialMessage
  def self.msg(record)
    <<-eol
      Привет, мы разместили Ваше объявление
      ----------------
      #{record.text}
      ----------------

      на ezpoisk.com, а также в группах в vk, fb и g+.

      Просмотреть:
        #{record.show_url}
      Редактировать/удалить:
        #{record.edit_url_with_token}
    eol
  end
end
