DISTANCE = [1, 5, 10, 25, 50, 100, 150, 200, 300, 500]
RE_COMMERCIAL_CATEGORIES = %w(Офис Торговля Промышленность Парковка Другое)
RE_TYPES = %w(Продажа Аренда)
RE_DURATION = %w(час сутки месяц)

JOB_TYPES = %w(Требуется Ищу)
JOB_CATEGORIES = [
  "Няня", "Сиделка", "Уборщица/горничная", "Курьер", "Удаленная",
  "Офис-менеджер", "Разнорабочие",
  "",
  "Автомойка", "Автосервис", "Водитель / Экспедитор", "Диспетчер",
  "Логистика и Перевозки", "Работник заправки",
  "",
  "Недвижимость", "Строительные специализации",
  "",
  "Банки, Кредитование, Лизинг", "Бухгалтерия", "Страхование", "Юриспруденция",
  "",
  "Инженеры/технологи производства", "Менеджмент производства",
  "Швейный бизнес", "Рабочие на производство",
  "",
  "Массаж", "Медицинский персонал", "Фармацевтика",
  "",
  "Дизайн и Графика", "Искусство", "Модели", "Артисты", "Развлечения",
  "Фото, видео, аудио",
  "",
  "Администрация ресторана", "Бармен", "Оффициант", "Работники кухни",
  "",
  "Визажист/Косметолог", "Мастер маникюра / педикюра", "Парикмахер, стилист",
  "",
  "Тренер, инструктор", "Воспитатель", "Преподавание",
  "",
  "Эскорт-сервис и массаж", "Охранники", "Туризм",
  "Программирование, компьютеры, интернет",
  "Торговля", "Маркетинг, Реклама, PR", "Временная, сезонная"
]

SALE_CATEGORIES = [
  "Все", "Транспорт", "Для дома", "Для детей", "Одежда", "Электроника",
  "Домашние животные, растения", "Распродажа"
]

SERVICE_CATEGORIES = HashWithIndifferentAccess.new(
  "Авто": [
    "Авто в аренду", "Автосервисы", "Автошкола", "Дилеры, акуцины",
    "Перевозки, moving", "Такси"
  ],
  "Адвокаты": [
    "Общий профиль", "Аварии, Медицинские ошибки",
    "Бизнес, Финансы, Банкроство", "Иммиграция", "Криминал",
    "Наследство, Завещания", "Недвижимость", "Семоейное право"
  ],
  "Косметология": [
    "Лазерная косметология", "Салоны красоты", "SPA, Бани, Сауны",
    "Пластическая хирургия"
  ],
  "Медицина": [
    "Медисцинский офис, Госптиаль", "Врач", "Аптеки", "Альтернативная медицина",
    "Ветеринарные клиники"
  ],
  "Образование": [
    "Университеты, Колледжы, Школы", "Танцы, Музыка, Искусство", "Десткие сады",
    "Курсы английского", "Репетиторы", "Спортивные школы", "Йога",
    "Обучение профессии"
  ],
  "Ремонт": [
    "Кондициоры, Отоплние", "Ремонт и сервис телефонов",
    "Ремонт бытовой техники, электроники", "Ремонт, пошив одежды",
    "Ремонт, настройка музыкальных инструментов"
  ],
  "Строительные работы": [
    "Строительные работы", "Эклектрики, Сантехники, Маляры и др",
    "Сигнализация, Видеонаблюдение", "Замки, Забры, Сварка",
    "Снос зданий, Мусор", "Архитектура, Дизайн", "Мастер на все руки"
  ],
  "Другие Услуги": [
    "Реклама и PR",
    "Туристические фирмы", "Уборка помещений", "Посылки, грузы", "Фото, Видео",
    "Артисты, праздники", "Компьтеры, интернет", "Истребление насекомых",
    "Детективы, охрана", "Переводы, печатные работы",
    "Сопровождение на встречах и отдыхе", "Массаж", "Няни, гувернантки"
  ]
)

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
]

NEWS_CATEGORIES = HashWithIndifferentAccess.new(
  "Интересное": [],
  "Железо": ["https://news.yandex.ru/hardware.rss", "hardware"],
  "Авто": ["https://news.yandex.ru/auto.rss", "auto"],
  "Общество": ["https://news.yandex.ru/world.rss", "world"],
  "Интернет": ["https://news.yandex.ru/internet.rss", "internet"],
  "Кино": ["https://news.yandex.ru/movies.rss", "movies"],
  "Культура": ["https://news.yandex.ru/culture.rss", "culture"],
  "Мода": ["https://news.yandex.ru/fashion.rss", "fashion"],
  "Музыка": ["https://news.yandex.ru/music.rss", "music"],
  "Наука": ["https://news.yandex.ru/science.rss", "science"],
  "Политика": ["https://news.yandex.ru/politics.rss", "politics"],
  "Происшествия": ["https://news.yandex.ru/incident.rss", "incident"],
  "Софт": ["https://news.yandex.ru/software.rss", "software"],
  "Технологии": ["https://news.yandex.ru/computers.rss", "computers"],
  "Финансы": ["https://news.yandex.ru/finances.rss", "finances"],
  "Шоу-бизнес": ["https://news.yandex.ru/showbusiness.rss", "showbusiness"],
  "Азербайджан": ["https://news.yandex.ru/Azerbaijan/index.rss", "Azerbaijan"],
  "Армения": ["https://news.yandex.ru/Armenia/index.rss", "Armenia"],
  "Беларусь": ["https://news.yandex.ru/Belarus/index.rss", "Belarus"],
  "Грузия": ["https://news.yandex.ru/Georgia/index.rss", "Georgia"],
  "Израиль": ["https://news.yandex.ru/Israel/index.rss", "Israel"],
  "Казахстан": ["https://news.yandex.ru/Kazakhstan/index.rss", "Kazakhstan"],
  "Киргизия": ["https://news.yandex.ru/Kirghizia/index.rss", "Kirghizia"],
  "Латвия": ["https://news.yandex.ru/Latvia/index.rss", "Latvia"],
  "Литва": ["https://news.yandex.ru/Lithuania/index.rss", "Lithuania"],
  "Молдова": ["https://news.yandex.ru/Moldova/index.rss", "Moldova"],
  "США": ["https://news.yandex.ru/USA/index.rss", "USA"],
  "Таджикистан": ["https://news.yandex.ru/Tadjikistan/index.rss", "Tadjikistan"],
  "Туркмения": ["https://news.yandex.ru/Turkmenistan/index.rss", "Turkmenistan"],
  "Узбекистан": ["https://news.yandex.ru/Uzbekistan/index.rss", "Uzbekistan"],
  "Украина": ["https://news.yandex.ua/index.rss", "Ukraine"]
)

HOROSCOPE_CATEGORIES = %w(БЛИЗНЕЦЫ ВЕСЫ ВОДОЛЕЙ ДЕВА КОЗЕРОГ ЛЕВ ОВЕН РАК
                          РЫБЫ СКОРПИОН СТРЕЛЕЦ ТЕЛЕЦ)
