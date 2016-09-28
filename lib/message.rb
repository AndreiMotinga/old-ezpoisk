class Message
  def self.message(record)
    <<-eol
      Привет, мы разместили Ваше объявление
      "#{record.text}"
      на
      #{record.show_url}
      а также в наших группах в vkontakte, facebook и google+.

      Вы можете его редактировать или удалить через
      #{record.edit_url_with_token}

      Советуем добавить телефон и email, и подправить остальные детали, так как
      это существенно увеличит его эффективность.

      Наша цель - сделать полезный ресурс для комьюнити.
      https://www.ezpoisk.com/posts/vsem-privet-i-dobro-pozhalovat-na-izi-poisk

      Я прошу прощения, если это доставило вам какие-либо неудобства.
    eol
  end
end
