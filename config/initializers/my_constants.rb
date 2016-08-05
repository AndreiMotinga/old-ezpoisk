# todo freeze these
RE_COMMERCIAL_CATEGORIES = [
  %w(Офис office),
  %w(Торговля sales),
  %w(Промышленность industry),
  %w(Парковка parking),
  %w(Другое other)
].freeze

RE_TYPES = [
  ["Сдаю в аренду", "leasing"],
  ["Ищу в аренду", "renting"],
  ["Продаю", "selling"],
  ["Хочу купить", "buying"]
].freeze

RE_DURATION = [
  %w(почасово hourly),
  %w(посуточно daily ),
  %w(понедельно weekly),
  %w(помесячно monthly)
].freeze

MODELS = [
  ["Частная", "RePrivate"],
  ["Коммерческая", "ReCommercial"],
  ["Услуги", "Service"],
  ["Работа", "Job"],
  ["Продается", "Sale" ],
  ["Новость", "Post" ],
  ["Вопрос", "Question" ]
].freeze

ROOM_OPTIONS  = [
  ["комната", "room"],
  ["место в комнате", "bed"],
  ["студия", "studio"],
  ["1-спальная", "1-bebroom"],
  ["2-спальная", "2-bebroom"],
  ["3-спальная", "3-bebroom"],
  ["4-спальная", "4-bebroom"],
  ["5-спальная", "5-bebroom"],
  ["6-спальная", "6-bebroom"],
  ["7-спальная", "7-bebroom"],
  ["8-спальная", "8-bebroom"],
  ["9-спальная", "9-bebroom"]
].freeze

JOB_CATEGORIES = [
  %w(Требуется wanted),
  %w(Ищу seeking),
].freeze

# todo
JOB_SUBCATEGORIES = HashWithIndifferentAccess.new(
  "Туризм, Рестораны, Бары": [
    ["все", "administration, watiers, bartenders, kitchen-workers, tourism"],
    ["администрация ресторана", "administration"],
    ["официант, бармен", "watiers, bartenders"],
    ["работники кухни", "kitchen-workers"],
    ["туризм", "tourism"]
  ],
  "Сельское хозяйство": [
    ["все", "agronomy, veterinary"],
    ["агрономия", "agronomy"],
    ["зоотехника и ветеринария", "veterinary"]
  ],
  "Юриспруденция и Страхование": [
    ["все", "law, insurance"],
    ["юристы, адвокаты, нотариусы", "law"],
    ["страхование, коллекторы, приставы, оценщики", "insurance"]
  ],
  "Спорт и Красота": [
    ["все", "makeup artist, manicure-pedicure, hairdresser, dancers, trainer"],
    ["визажист/косметолог", "makeup artist"],
    ["мастер маникюра / педикюра", "manicure-pedicure"],
    ["парикмахер, стилист", "hairdresser"],
    ["танцовщицы", "dancers"],
    ["тренер, инструктор", "trainer"]
  ],
  "Банки, Финансы, Бухгалтерия": [
    ["все", "auditing, lease, accounting"],
    ["аудиторство", "auditing"],
    ["банки, кредитование, лизинг", "lease"],
    ["бухгалтерия", "accounting"]
  ],
  "Образование": [
    ["все", "teachers, preschool, language, trainings"],
    ["преподаватели, репетиторы", "teachers"],
    ["дошкольное образование", "preschool"],
    ["иностранные языки", "language"],
    ["курсы, семинары, тренинги", "trainings"]
  ],
  "Дизайн, Искусство, Развлечения": [
    ["все", "design, art, entertainment, photo-video"],
    ["дизайн и графика", "design"],
    ["искусство", "art"],
    ["развлечения", "entertainment"],
    ["фото, видео, аудио", "photo-video"]
  ],
  "Транспорт и Логистика": [
    ["Все", "carwash, autoservice, driver, moving, gas-stations"],
    ["автомойка", "carwash"],
    ["автосервис", "autoservice"],
    ["водитель / экспедитор", "driver"],
    ["логистика и перевозки", "moving"],
    ["работник заправки", "gas-stations"],
  ],
  "Медицина и Фармацевтика": [
    ["все", "massage, hospitals, farmacies"],
    ["массаж", "massage"],
    ["медицинский персонал", "hospitals"],
    ["фармацевтика", "farmacies"]
  ],
  "IT и Телекоммуникации": [
    ["все", "development, management, network, telecommunications, tech-repairs, seo"],
    ["it программирование", "development"],
    ["it менеджмент", "management"],
    ["системное администрирование", "network"],
    ["телекоммуникации", "telecommunications"],
    ["ремонт компьютеров и телефонов", "tech-repairs"],
    ["seo", "seo"]
  ],
  "Производство, промышленность": [
    ["все", "engineers, ingustry-maganers, sewing, production-worker"],
    ["инженеры/технологи производства", "engineers"],
    ["менеджмент производства", "ingustry-maganers"],
    ["швейный бизнес", "sewing"],
    ["рабочие на производство", "production-worker"]
  ],
  "Строительство и Недвижимость": [
    ["все", "realty, architecture, building-materials, building-expertise"],
    ["недвижимость", "realty"],
    ["проектирование и архитектура", "architecture"],
    ["производство стройматериалов", "building-materials"],
    ["строительные специализации", "building-expertise"]
  ],
  "СМИ, Журналистика, Переводы": [
    ["все", "host, journalists, tranlations, producers"],
    ["ведущий", "host"],
    ["журналистика", "journalists"],
    ["переводчики", "tranlations"],
    ["продюсер", "producers"]
  ],
  "Торговля и Продажи": [
    ["все", "customer-support, retailers, telemarketing, sale-representatives, sales-magagement"],
    ["менеджер по работе с клиентами", "customer-support"],
    ["продавцы, кассиры", "retailers"],
    ["продажи по телефону (телемаркетинг)", "telemarketing"],
    ["торговые представители", "sale-representatives"],
    ["управление продажами", "sales-magagement"]
  ],
  "Охрана и Безопасность": [
    ["все", "bodyguard, security"],
    ["охранник / телохранитель", "bodyguard"],
    ["специалист по безопасности", "security"]
  ],
  "Персонал для дома и офиса": [
    ["все", "curier, remote-work, home-attendant, front-desk, misc, cleaning"],
    ["курьер", "curier"],
    ["удаленная работа", "remote-work"],
    ["няня, сиделка", "home-attendant"],
    ["офис-менеджер / секретарь", "front-desk"],
    ["разнорабочие", "misc"],
    ["уборщица/горничная", "cleaning"]
  ],
  "HR, Соц. работа": [
    ["все", "психология / соц. работа, hr, кадры"],
    ["психология / соц. работа", "social"],
    ["hr, кадры", "human-resources"]
  ],
  "Маркетинг, Реклама, PR": [
    ["все", "копирайтинг / контент-менеджмент, маркетинг, промоутер, pr"],
    ["копирайтинг / контент-менеджмент", "copywriters"],
    ["маркетинг", "marketing"],
    ["промоутер", "promoters"],
    ["pr" , "pr"]
  ],
  "Другое": [
    ["другое", "other"]
  ]
).freeze

SALE_CATEGORIES = [
  ["Транспорт", "transportation"],
  ["Для дома", "home"],
  ["Для детей", "kids"],
  ["Одежда", "clothes"],
  ["Электроника", "electronics"],
  ["Домашние животные", "pets"],
  ["Растения", "plants"],
  ["Распродажа", "sales"]
].freeze

SERVICE_CATEGORIES = [
  ["Автоуслуги", "auto"],
  ["Адвокаты", "lawers"],
  ["Красота", "beauty"],
  ["Медицина", "medical"],
  ["Недвижимость", "real-estate"],
  ["Образование", "education"],
  ["Работа", "work"],
  ["Ремонт", "repairs"],
  ["Строительство", "construction"],
  ["Магазины", "stores"],
  ["Другие услуги", "other"]
].freeze

SERVICE_SUBCATEGORIES = HashWithIndifferentAccess.new(
  "auto": [
    ["Авто в аренду", "car-rentals"],
    ["Автосервисы", "autoservices"],
    ["Автомойки", "carwash"],
    ["Автомагазины", "auto-stores"],
    ["Автошколы", "driver-schools"],
    ["Дилеры, аукционы", "auto-auction"],
    ["Moving, грузоперевозки", "moving"],
    ["Такси, CarService", "carservice"]
  ],
  "lawers": [
    ["Общий профиль", "general"],
    ["Аварии, Медицинские ошибки", "accidents"],
    ["Бизнес, Финансы, Банкротство", "business"],
    ["Нотариальные услуги", "paralegal"],
    ["Иммиграция", "immigration"],
    ["Криминал", "criminal"],
    ["Наследство, Завещания", "heritage"],
    ["Недвижимость", "realty"],
    ["Семейное право", "family"]
  ],
  "beauty": [
    ["Салоны красоты, парикмахерские", "beauty-salons"],
    ["SPA, солярий, массаж, уход за телом", "spa"],
    ["Коррекция фигуры и лица", "correction"],
    ["Эпиляция, лазерная косметология", "epilation"],
    ["Татуировка, татуаж", "tatoo"],
    ["Бани, Сауны", "saunas"]
  ],
  "medical": [
    ["Медицинский офис, Госпиталь", "hospitals"],
    ["Аптеки", "farmacies"],
    ["Альтернативная медицина", "alternative-medicine"],
    ["Ветеринарные клиники", "veterinary-clinics"],
    ["Аллерголог", "allergist"],
    ["Венеролог", "venereologist"],
    ["Гинеколог, акушер", "gynecologis"],
    ["Дермотолог", "dermotolog"],
    ["Диетолог", "nutritionist"],
    ["Иммунолог", "immunologist"],
    ["Кардиолог", "cardiologist"],
    ["Косметолог", "beautician"],
    ["ЛОР", "ent"],
    ["Мануальный терапевт", "chiropractor"],
    ["Невролог", "neurologist"],
    ["Стоматолог", "dentist"],
    ["Онколог", "oncologist"],
    ["Ортопед", "orthopedist"],
    ["Офтальмолог", "ophthalmologist"],
    ["Педиатр", "pediatrician"],
    ["Пластический хирург", "plastic-surgeon"],
    ["Психиатр, нарколог", "psychiatrist"],
    ["Психолог", "psychologist"],
    ["Сексопатолог", "seksopatolog"],
    ["Семейный доктор", "family-doctor"],
    ["Терапевт", "therapist"],
    ["Уролог, андролог", "urologist"],
    ["Хирург, проктолог", "surgeon"],
    ["Физиотерапевт, массажист, хиропрактор", "physiotherapist"],
    ["Эндокринолог", "endocrinologist"],
  ],
  "real-estate": [
    ["Агентства Недвижимости", "realy"],
    ["Финансирование", "fanancing"]
  ],
  "education": [
    ["Университеты, Колледжы, Школы", "schools"],
    ["Танцы, Музыка, Искусство", "art-education"],
    ["Детские сады", "kinder-gardens"],
    ["Курсы английского", "english-lessons"],
    ["Репетиторы", "teachers"],
    ["Спортивные школы", "sport-schools"],
    ["Обучение профессии", "trainings"]
  ],
  "work": [
    ["Агентства по Трудоустройству", "job-agencies"]
  ],
  "repairs": [
    ["Ремонт и сервис телефонов", "cellphone-repair"],
    ["Ремонт компьютеров", "computer-repair"],
    ["Ремонт бытовой техники, электроники", "appliances-repair"],
    ["Ремонт, пошив одежды, обуви", "clothes-repais"],
    ["Ремонт, настройка музыкальных инструментов", "musical-instruments-repair-tuning"]
  ],
  "construction": [
    ["Строительные компании", "construction-companies"],
    ["Электрики", "electicians"],
    ["Сантехники", "plumbers"],
    ["Маляры", "painters"],
    ["Мастер на все руки, Handyman", "handymen"],
    ["Изготовление мебели", "furniture"],
    ["Сигнализация, Видеонаблюдение", "alarm-video-surveillance"],
    ["Замки", "locks"],
    ["Заборы, Сварка", "fences-welding"],
    ["Снос зданий, Мусор", "garbage"],
    ["Ремонт и дизайн помещений", "interior-design"],
    ["Кондиционеры, Отопление", "air-conditioning"]
  ],
  "stores": [
    ["Детские товары", "kid-goods"],
    ["Магазины с доставкой", "stores-with-delivery"],
    ["Зоотовары", "pet-stores"],
    ["Интернет-магазины", "online-stores"],
    ["Канцелярские товары", "stationery"],
    ["Книги, печатная продукция", "book-stores"],
    ["Одежда", "clothes-stores"],
    ["Обувь", "shoe-stores"],
    ["Парфюмерия и косметика", "perfumes-cosmetics-stores"],
    ["Подарки, сувениры", "gift-stores"],
    ["Продукты", "food"],
    ["Сад и огород", "garden"],
    ["Ткани и товары для рукоделия", "fabric-craft-supplies"],
    ["Товары для спорта", ""],
    ["Хозтовары", "household-goods"],
    ["Цветы", "flower-stores"],
    ["Часы", "wathces"],
    ["Ювелирные изделия", "jewlery"],
    ["Автозапчасти" "car-parts"],
  ],
  "other": [
    ["Артисты, праздники", "artists-celebrities"],
    ["Бизнес, партнерства", "business"],
    ["Детективы, охрана", "detectives"],
    ["Истребление насекомых", "exterminators"],
    ["Компьютеры, интернет", "computers"],
    ["Няни, гувернантки", "nannies"],
    ["Переводы, печатные работы", "tranlations"],
    ["Посылки, грузы", "parcels"],
    ["Реклама и PR", "advertisement"],
    ["Рестораны, развлечения", "restourants"],
    ["Ритуальные услуги", "funeral-services"],
    ["Спорт, фитнес", "sports"],
    ["Сопровождение на встречах и отдыхе", "escort"],
    ["Страхование", "insurance"],
    ["Туристические фирмы", "tourism"],
    ["Танцы", "dance"],
    ["Уборка помещений", "cleaning"],
    ["Финансы, налоги", "finances-taxes"],
    ["Фото, Видео", "photo-video"],
    ["Художники, искусство", "art"],
    ["Цветы", "flowers"],
    ["Эротический Массаж", "erotics-massage"],
    ["Экстрасенсы", "psychics"]
  ]
).freeze

STATES = [
  [ "Alabama", 1 ],
  [ "Alaska", 2 ],
  [ "Arizona", 3 ],
  [ "Arkansas", 4 ],
  [ "California", 5 ],
  [ "Colorado", 6 ],
  [ "Connecticut", 7 ],
  [ "Delaware", 8 ],
  [ "Florida", 9 ],
  [ "Georgia", 10 ],
  [ "Hawaii", 11 ],
  [ "Idaho", 12 ],
  [ "Illinois", 13 ],
  [ "Indiana", 14 ],
  [ "Iowa", 15 ],
  [ "Kansas", 16 ],
  [ "Kentucky", 17 ],
  [ "Louisiana", 18 ],
  [ "Maine", 19 ],
  [ "Maryland", 20 ],
  [ "Massachusetts", 21 ],
  [ "Michigan", 22 ],
  [ "Minnesota", 23 ],
  [ "Mississippi", 24 ],
  [ "Missouri", 25 ],
  [ "Montana", 26 ],
  [ "Nebraska", 27 ],
  [ "Nevada", 28 ],
  [ "New Hampshire", 29 ],
  [ "New Jersey", 30 ],
  [ "New Mexico", 31 ],
  [ "New York", 32 ],
  [ "North Carolina", 33 ],
  [ "North Dakota", 34 ],
  [ "Ohio", 35 ],
  [ "Oklahoma", 36 ],
  [ "Oregon", 37 ],
  [ "Pennsylvania", 38 ],
  [ "Rhode Island", 39 ],
  [ "South Carolina", 40 ],
  [ "South Dakota", 41 ],
  [ "Tennessee", 42 ],
  [ "Texas", 43 ],
  [ "Utah", 44 ],
  [ "Vermont", 45 ],
  [ "Virginia", 46 ],
  [ "Washington", 47 ],
  [ "West Virginia", 48 ],
  [ "Wisconsin", 49 ],
  [ "Wyoming", 50 ]
].freeze

NEWS_CATEGORIES = [
  "https://news.yandex.ru/auto.rss",
  "https://news.yandex.ru/world.rss",
  "https://news.yandex.ru/internet.rss",
  "https://news.yandex.ru/movies.rss",
  "https://news.yandex.ru/fashion.rss",
  "https://news.yandex.ru/music.rss",
  "https://news.yandex.ru/science.rss",
  "https://news.yandex.ru/computers.rss",
   "https://news.yandex.ru/politics.rss",
   "https://news.yandex.ru/finances.rss",
   "https://news.yandex.ru/Belarus/index.rss",
   "https://news.yandex.ru/Israel/index.rss",
   "https://news.yandex.ru/Kazakhstan/index.rss",
   "https://news.yandex.ru/Moldova/index.rss",
   "https://news.yandex.ru/USA/index.rss",
   "https://news.yandex.ua/index.rss"
].freeze

PARTNER_PAGES = HashWithIndifferentAccess.new(
      "Домашняя" => ["Домашняя"],
      "- Раздел Недвижимость" => [
        "Частная", "Коммерческая", "Агентства Недвижимости", "Финансирование"
      ],
      "- Раздел Работа" => ["Работа", "Агентства по Трудоустройству"],
      "- Раздел Вопросы" => ["Вопросы"],
      "- Раздел Новости" => ["Новости"],
      "- Раздел Продажи" => SALE_CATEGORIES,
      "- Раздел Услуги" => []
)

SERVICE_SUBCATEGORIES.each { |ctg, subctg| PARTNER_PAGES[ctg] = subctg }
