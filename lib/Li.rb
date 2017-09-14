class Li
  attr_reader :link, :url

  def self.import(link)
    new(link).import
  end

  def self.convert(link)
    new(link).convert
  end

  def initialize(link)
    @link = link
    @url = "https://svoi.us#{link.source}"
  end

  def import
    doc = Nokogiri::HTML(open(url))
    title = doc.css("h1.promo-companies__desk-line1").text
    category = doc.css("p.promo-companies__desk-line2").text.strip
    desc = doc.css("div.t-descr_xxs").first.css("p").text

    tags = doc.css("div.t-descr_xxs")[1].css("a")
    phones = doc.css(".t-phones a")
    contacts = (tags + phones).map {|contact| [contact['href'], contact['title']] }

    phone = contacts.select{|con| con[1] == "Телефон" }&.flatten&.first
    site = contacts.select{|con| con[1] == "Сайт" }&.flatten&.first
    email = contacts.select{|con| con[1] == "E-mail" }&.flatten&.first
    subs = contacts.map {|con| con[1]}.reject{ |word| %w(Телефон E-mail Сайт).include? word }.join(",")

    address = doc.css("script")[7]&.text
    pictures = doc.css(".photos-subdiv a").map {|pic| pic['href']}.join(",")

    link.update({
      title: title,
      category: category,
      description: desc,
      phone: phone,
      site: site,
      email: email,
      subs: subs,
      address: address,
      pictures: pictures
    })
  end

  def convert
    l = Listing.create(
      user_id: 1,
      active: false,
      kind: "услуги",
      category: "imported",
      subcategory: "unknown",
      title: link.title,
      text: link.description,
      site: link.site,
      phone: link.phone,
      email: link.email
    )
  end

  def self.update_categories
    Link.where(category: "Прочие магазины").update_all(category: "другое-разное", subcategory: "магазины")
    Link.where(category: "Салоны красоты").update_all(category: "красота", subcategory: "салоны-красоты--парикмахерские")
    Link.where(category: "Компьютеры, интернет").update_all(category: "другое-разное", subcategory: "компьютеры--интернет")
    Link.where(category: "Страхование").update_all(category: "другое-разное", subcategory: "страхование")
    Link.where(category: ["Путешествия", "Туристические агентства"]).update_all(category: "другое-разное", subcategory: "туристические-фирмы")
    Link.where(category: "Детские сады и сервис").update_all(category: "образование", subcategory: "детские-сады")
    Link.where(category: ["Бытовая техника","Ремонт и обслуживание"]).update_all(category: "ремонт", subcategory: "")
    Link.where(category: "Почта и пересылка").update_all(category: "другое-разное", subcategory: "посылки--грузы")
    Link.where(category: "Уборка домов").update_all(category: "другое-разное", subcategory: "уборка")
    Link.where(category: "Кружки и уроки").update_all(category: "образование")
    Link.where(category: "Грузоперевозки").update_all(category: "автоуслуги", subcategory: "грузоперевозки-moving")
    Link.where(category: "Дома престарелых").update_all(category: "дома-престарелых")
    Link.where(category: "Медицина здоровье").update_all(category: "медицина")
    Link.where(category: "Альтернативная медицина").update_all(category: "медицина")
    Link.where(category: "Кондиционеры, свет, газ").update_all(category: "ремонт")
    Link.where(category: "Юристы").update_all(category: "адвокаты")
    Link.where(category: "Учебные центры").update_all(category: "образование")
    Link.where(category: "Полиграфия, печать").update_all(category: "переводы--печатные-работы")
    Link.where(category: "Медицинские центры").update_all(category: "медицина")
    Link.where(category: "Электрики").update_all(category: "строительство--ремонт", subcategory: "электрики")
    Link.where(category: "Семейный доктор, кардиология").update_all(category: "медицина", subcategory: "кардиолог")
    Link.where(category: "Аптеки").update_all(category: "медицина", subcategory: "аптеки")
    Link.where(category: "Агенты недвижимости").update_all(category: "недвижимость", subcategory: "агентства-недвижимости")
    Link.where(category: "Спортивные школы").update_all(category: "образование", subcategory: "спортивные-школы")
    Link.where(category: "Бухгалтерские услуги, налоги").update_all(category: "другое-разное", subcategory: "бухгалтеры-финансы-налоги")
    Link.where(category: "Школы танца и музыки").update_all(category: "образование", subcategory: "танцы")
    Link.where(category: "Фотограф").update_all(category: "другое-разное", subcategory: "фото--видео--аудио")
    Link.where(category: "Рестораны").update_all(category: "другое-разное", subcategory: "бары--кафе--рестораны")
    Link.where(category: "Магазины продуктовые").update_all(category: "другое-разное", subcategory: "магазины")
    Link.where(category: ["Ремонт и реконструкция домов", "Строительство новых домов", "Ковры, полы", "Крыши"]).update_all(category: "строительство--ремонт", subcategory: "строительные-компании")
    Link.where(category: "Прочие бизнесы").update_all(category: "другое-разное", subcategory: "другое-разное")
    Link.where(category: "Магазины мебельные").update_all(category: "магазины", subcategory: "мебель")
    Link.where(category: "Зубной доктор, стоматология").update_all(category: "медицина", subcategory: "стоматолог")
    Link.where(category: "Иммиграционное обслуживание").update_all(category: "адвокаты", subcategory: "иммиграция")
    Link.where(category: [ "Дилеры, новые авто", "Продажа авто" ]).update_all(category: "автоуслуги", subcategory: "дилеры--аукционы")
    Link.where(category: "Автошколы").update_all(category: "автоуслуги", subcategory: "автошколы")
    Link.where(category: "Агентства помощи по дому").update_all(category: "работа", subcategory: "подбор-персонала")
    Link.where(category: "Клубы").update_all(category: "другое-разное", subcategory: "бары--кафе--рестораны")
    Link.where(category: ["Колледжи и Университеты", "Образование, школы", "Уроки, Классы", "Образование"]).update_all(category: "образование", subcategory: "университеты--колледжы--школы")
    Link.where(category: "Консультационные, переводческие и нотариальные услуги").update_all(category: "адвокаты", subcategory: "нотариальные-услуги")
    Link.where(category: "Финансовые услуги").update_all(category: "другое-разное", subcategory: "бухгалтеры-финансы-налоги")
    Link.where(category: "Педиатры").update_all(category: "медицина", subcategory: "педиатр")
    Link.where(category: "Агентства по найму").update_all(category: "работа", subcategory: "агентства-по-трудоустройству")
    Link.where(category: ["Синагоги и Еврейские центры", "Церкви, религиозные центры"]).update_all(category: "другое-разное", subcategory: "церкви--синагоги--религия")
    Link.where(category: "Свадебные салоны и услуги").update_all(category: "другое-разное", subcategory: "свадебные-салоны")
    Link.where(category: "Химчистка и пошив одежды").update_all(category: "ремонт", subcategory: "ремонт-пошив-одежды")
    Link.where(category: "Маркетинг, реклама").update_all(category: "другое-разное", subcategory: "реклама--pr")
    Link.where(category: "Такси и лимузины").update_all(category: "автоуслуги", subcategory: "такси-carservice")
    Link.where(category: "Психиатрия и психология").update_all(category: "медицина", subcategory: "психолог")
    Link.where(category: "СМИ").destroy_all
    Link.where(category: ["Вечеринки и праздники", "Музыка, коллективы"]).update_all(category: "другое-разное", subcategory: "артисты--праздники")
    Link.where(category: "Косметология, проблемы кожи").update_all(category: "красота")
    Link.where(category: "Изучение языков").update_all(category: "образование", subcategory: "языковые школы")
    Link.where(category: "Хирурги").update_all(category: "медицина", subcategory: "хирург")
    Link.where(category: "Неврология").update_all(category: "медицина", subcategory: "невролог")
    Link.where(category: "Гинекологи, урологи").update_all(category: "медицина", subcategory: "гинеколог-акушер")
    Link.where(category: "Бизнес-услуги").update_all(category: "другое-разное", subcategory: "бизнес--партнерства")
    Link.where(category: "ТВ, фото, телефоны").update_all(category: "другое-разное", subcategory: "фото--видео--аудио")
    Link.where(category: "Реабилитационные центры").update_all(category: "работа", subcategory: "реабилитационный-центр")
    Link.where(category: "Окулисты, офтальмологи").update_all(category: "медицина", subcategory: "офтальмолог")
    Link.where(category: "Бани, оздоровительные центры").update_all(category: "другое-разное", subcategory: "бани-сауны")
    Link.where(category: "Медицинское оборудование и обеспечение").update_all(category: "медицина", subcategory: "медицинское-оборудование")
    Listing.where(category: "красота", subcategory: "массаж").update_all(category: "медицина")
    Listing.where(category: "медицина", subcategory: "мануальный-терапевт").update_all(subcategory: "массаж")
    Link.where(category: "Книги, видео, аудио").update_all(category: "другое-разное", subcategory: "фото--видео--аудио")
    Link.where(category: "Одежда").update_all(category: "магазины", subcategory: "одежда")
    Link.where(category: "Массаж").update_all(category: "медицина", subcategory: "массаж")
    Link.where(category: ["Ландшафтная архитектура", "Архитекторы, Дизайн"]).update_all(category: "строительство--ремонт", subcategory: "дизайн-помещений")
    Link.where(category: "Похоронные бюро").update_all(category: "другое-разное", subcategory: "ритуальные-услуги")
    Link.where(category: "Картинные галереи").update_all(category: "другое-разное", subcategory: "искусство")
    Link.where(category: "Магазины").update_all(category: "магазины")
    Link.where(category: "Гостиницы, аренда").destroy_all
    Listing.where(subcategory: "кондитеры").update_all(subcategory: "кондитеры--пекари")
    Link.where(category: "Спорт").destroy_all
    Link.where(category: "Булочные, пекарни").update_all(category: "другое-разное", subcategory: "кондитеры--пекари")
    Link.where(category: "Окна, Двери").update_all(category: "строительство--ремонт", subcategory: "окна-двери")
    Link.where(category: "Водопровод, бассейны").update_all(category: "строительство--ремонт", subcategory: "сантехники")
    Link.where(category: "Ссуды").update_all(category: "другое-разное", subcategory: "финансирование")
    Link.where(category: "Аренда авто").update_all(category: "автоуслуги", subcategory: "авто-в-аренду")
    Link.where(category: ["Животные, ветеринария", "Ветеринар"]).update_all(category: "медицина", subcategory: "ветеринарные-клиники")
    Link.where(category: "Сервис").destroy_all
    Link.where(category: "Другие").update_all(category: "другое-разное", subcategory: "другое-разное")
    Link.where(category: "Косметические операции").update_all(category: "медицина", subcategory: "пластический-хирург")
    Link.where(category: "Ухо, горло, нос",).update_all(category: "медицина", subcategory: "лор")
    Link.where(category: "Аллергологи, иммунная система").update_all(category: "медицина", subcategory: "аллерголог")
    Link.where(category: "Община").destroy_all
    Link.where(category: "Отдых, развлечения").update_all(category: "другое-разное", subcategory: "отдых--развлечения")
    Link.where(category: "Скорая помощь").destroy_all
    Link.where(category: "Театры").destroy_all
    Link.where(category: "Бизнес, финансы").update_all(category: "другое-разное", subcategory: "бизнес--партнерства")
    Link.where(category: "Музыкальные инструменты").destroy_all
    Link.where(category: "Искусство, мода").update_all(category: "другое-разное", subcategory: "искусство")
    Link.where(category: "Производство, оптовая торговля").destroy_all
    Link.where(category: "Семья").destroy_all
    Link.where(category: "Банки").destroy_all
  end
end

