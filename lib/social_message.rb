class SocialMessage
  def self.message(record)
    <<-eol
      Здравствуйте, мы разместили Ваше объявление на
      #{record.show_url}, а также в наших группах в vkontakte, facebook и google+.

      Вы можете его редактировать или удалить через  #{record.edit_url_with_token}
      Советуем добавить телефон и email, и подправить остальные детали, так как
      это существенно увеличит его эффективность.

      "Спасибо" приветствуется, но остается на усмотрение клиента))

      P.S Сделайте доброе дело, помогите нам пожалуйста рассказать о сайте, это займет у вас меньше минуты.
      https://www.ezpoisk.com/posts/vsem-privet-i-dobro-pozhalovat-na-izi-poisk
    eol
  end
end
