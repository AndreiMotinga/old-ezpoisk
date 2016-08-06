RE_COMMERCIAL_CATEGORIES = %w(office sales industry parking other).freeze
RE_TYPES = %w(leasing renting selling buying).freeze
RE_DURATION = %w(monthly weekly daily hourly).freeze
ROOM_OPTIONS = %w(room bed studio 1-bebroom 2-bebroom 3-bebroom 4-bebroom
                  5-bebroom 6-bebroom 7-bebroom 8-bebroom 9-bebroom).freeze
SALE_CATEGORIES = %w(transportation home kids clothes electronics pets plants
                     sales).freeze
JOB_CATEGORIES = %w(wanted seeking).freeze

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

SERVICE_SUBCATEGORIES = HashWithIndifferentAccess.new(
  "auto": %w(car-rentals autoservices carwash auto-stores driver-schools
             auto-auction moving carservice),
  "lawers": %w(general accidents business paralegal immigration criminal
               heritage realty family),
  "beauty": %w(beauty-salons spa correction epilation tatoo sauna),
  "medical": %w(hospitals farmacies alternative-medicine veterinary-clinics
                allergist venereologist gynecologis dermotolog nutritionist
                immunologist cardiologist beautician ent chiropractor
                neurologist dentist oncologist orthopedist ophthalmologist
                pediatrician plastic-surgeon psychiatrist psychologist
                seksopatolog family-doctor therapist urologist surgeon
                physiotherapist endocrinologist),
  "real-estate": %w(realtors financing),
  "education": %w(schools art-education kinder-gardens english-lessons
                  teachers sport-schools training),
  "work": %w(job-agencies),
  "repairs": %w(cellphone-repair computer-repair appliances-repair
                clothes-repais musical-instruments-repair-tuning),
  "construction": %w(construction-companies electicians plumbers painters
                     handymen furniture alarm-video-surveillance locks
                     fences-welding garbage interior-design air-conditioning),
  "stores": %w(kid-goods stores-with-delivery pet-stores online-stores
               stationery book-stores clothes-stores shoe-stores
               perfumes-cosmetics-stores gift-stores food garden
               fabric-craft-supplies household-goods flower-stores wathces
               jewlery car-parts),
  "other": %w(artists-celebrities business detectives exterminators
              computers nannies tranlations parcels advertisement
              restourants funeral-services sports escort insurance tourism
              dance cleaning finances-taxes photo-video art flowers
              erotics-massage psychic)
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

# PARTNER_PAGES = HashWithIndifferentAccess.new(
#       "Домашняя" => ["Домашняя"],
#       "- Раздел Недвижимость" => [
#         "Частная", "Коммерческая", "Агентства Недвижимости", "Финансирование"
#       ],
#       "- Раздел Работа" => ["Работа", "Агентства по Трудоустройству"],
#       "- Раздел Вопросы" => ["Вопросы"],
#       "- Раздел Новости" => ["Новости"],
#       "- Раздел Продажи" => SALE_CATEGORIES,
#       "- Раздел Услуги" => []
# )
#
# SERVICE_SUBCATEGORIES.each { |ctg, subctg| PARTNER_PAGES[ctg] = subctg }
