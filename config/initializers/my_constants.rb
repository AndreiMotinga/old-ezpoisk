DISTANCE = [1, 5, 10, 25, 50, 100, 150, 200, 300, 500]
RE_COMMERCIAL_CATEGORIES = %w(Офис Торговля Промышленность Парковка Другое)
RE_TYPES = %w(Продажа Аренда)
RE_DURATION = %w(почасово посуточно помесячно)
MODELS = [
  ["Агентство Недвижимости", "ReAgency" ],
  ["Частная", "RePrivate"],
  ["Коммерческая", "ReCommercial"],
  ["Агентство по трудоустройству", "JobAgency"],
  ["Работа", "Job"],
  ["Услуги", "Service"],
  ["Продается", "Sale" ]
]
ROOM_OPTIONS  = [
  "комната",
  "студия",
  "1-комнатная",
  "2-комнатная",
  "3-комнатная",
  "4-комнатная",
  "5-комнатная",
  "6-комнатная",
  "7-комнатная",
  "8-комнатная",
  "9-комнатная"
]

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
  "Транспорт", "Для дома", "Для детей", "Одежда", "Электроника",
  "Домашние животные, растения", "Распродажа"
]

SERVICE_CATEGORIES = HashWithIndifferentAccess.new(
  "Автоуслуги": [
    "Авто в аренду",
    "Автосервисы",
    "Автомойки",
    "Автомагазины",
    "Автошколы",
    "Дилеры, аукционы",
    "Moving, грузоперевозки",
    "Такси, CarService"
  ],
  "Адвокаты": [
    "Общий профиль",
    "Аварии, Медицинские ошибки",
    "Бизнес, Финансы, Банкроство",
    "Нотариальные услуги",
    "Иммиграция",
    "Криминал",
    "Наследство, Завещания",
    "Недвижимость",
    "Семейное право"
  ],
  "Красота": [
    "Салоны красоты, парикмахерские",
    "SPA, солярий, массаж, уход за телом",
    "Коррекция фигуры и лица",
    "Эпиляция, лазерная косметология",
    "Татуировка, татуаж",
    "Бани, Сауны"
  ],
  "Медицина": [
    "Медицинский офис, Госпиталь",
    "Аптеки",
    "Альтернативная медицина",
    "Ветеринарные клиники",
    "Аллерголог",
    "Венеролог",
    "Гинеколог, акушер",
    "Дермотолог",
    "Диетолог",
    "Иммунолог",
    "Кардиолог",
    "Косметолог",
    "ЛОР",
    "Мануальный терапевт",
    "Невролог",
    "Стоматолог",
    "Онколог",
    "Ортопед",
    "Офтальмолог",
    "Педиатр",
    "Пластический хирург",
    "Психиатр, нарколог",
    "Психолог",
    "Сексопатолог",
    "Семейный доктор",
    "Терапевт",
    "Уролог, андролог",
    "Хирург, проктолог",
    "Физиотерапевт, массажист, хиропрактор",
    "Эндокринолог",
  ],
  "Образование": [
    "Университеты, Колледжы, Школы",
    "Танцы, Музыка, Искусство",
    "Детские сады",
    "Курсы английского",
    "Репетиторы",
    "Спортивные школы",
    "Обучение профессии"
  ],
  "Ремонт": [
    "Ремонт и сервис телефонов",
    "Ремонт компьютеров",
    "Ремонт бытовой техники, электроники",
    "Ремонт, пошив одежды, обуви",
    "Ремонт, настройка музыкальных инструментов"
  ],
  "Строительство": [
    "Строительные компании",
    "Электрики",
    "Сантехники",
    "Маляры",
    "Мастер на все руки, Handyman",
    "Изготовление мебели",
    "Сигнализация, Видеонаблюдение",
    "Замки",
    "Забры, Сварка",
    "Снос зданий, Мусор",
    "Ремонт и дизайн помещений",
    "Кондиционеры, Отопление"
  ],
  "Магазины": [
    "Детские товары",
    "Магазины с доставкой",
    "Зоотовары",
    "Интернет-магазины",
    "Канцелярские товары",
    "Книги, печатная продукция",
    "Одежда",
    "Обувь",
    "Парфюмерия и косметика",
    "Подарки, сувениры",
    "Продукты",
    "Сад и огород",
    "Ткани и товары для рукоделия",
    "Товары для спорта",
    "Хозтовары",
    "Цветы",
    "Часы",
    "Ювелирные изделия",
    "Автозапчасти"
  ],
  "Другие услуги": [
    "Артисты, праздники",
    "Бизнес, партнерства",
    "Детективы, охрана",
    "Истребление насекомых",
    "Компьютеры, интернет",
    "Няни, гувернантки",
    "Переводы, печатные работы",
    "Посылки, грузы",
    "Реклама и PR",
    "Рестораны, развлечения",
    "Ритуальные услуги",
    "Спорт, фитнес",
    "Сопровождение на встречах и отдыхе",
    "Страхование",
    "Туристические фирмы",
    "Танцы",
    "Уборка помещений",
    "Финансы, налоги",
    "Фото, Видео",
    "Цветы",
    "Эротический Массаж",
    "Экстрасенсы"
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
  "Авто": ["https://news.yandex.ru/auto.rss", "auto"],
  "Общество": ["https://news.yandex.ru/world.rss", "world"],
  "Интернет": ["https://news.yandex.ru/internet.rss", "internet"],
  "Кино": ["https://news.yandex.ru/movies.rss", "movies"],
  "Мода": ["https://news.yandex.ru/fashion.rss", "fashion"],
  "Музыка": ["https://news.yandex.ru/music.rss", "music"],
  "Наука": ["https://news.yandex.ru/science.rss", "science"],
  "Политика": ["https://news.yandex.ru/politics.rss", "politics"],
  "Технологии": ["https://news.yandex.ru/computers.rss", "computers"],
  "Финансы": ["https://news.yandex.ru/finances.rss", "finances"],
  "Страны": [
    ["https://news.yandex.ru/Azerbaijan/index.rss", "Азербайджан"],
    ["https://news.yandex.ru/Armenia/index.rss", "Армения"],
    ["https://news.yandex.ru/Belarus/index.rss", "Беларусь"],
    ["https://news.yandex.ru/Georgia/index.rss", "Грузия"],
    ["https://news.yandex.ru/Israel/index.rss", "Израиль"],
    ["https://news.yandex.ru/Kazakhstan/index.rss", "Казахстан"],
    ["https://news.yandex.ru/Kirghizia/index.rss", "Киргизия"],
    ["https://news.yandex.ru/Latvia/index.rss", "Латвия"],
    ["https://news.yandex.ru/Lithuania/index.rss", "Литва"],
    ["https://news.yandex.ru/Moldova/index.rss", "Молдова"],
    ["https://news.yandex.ru/USA/index.rss", "США"],
    ["https://news.yandex.ru/Tadjikistan/index.rss", "Таджикистан"],
    ["https://news.yandex.ru/Turkmenistan/index.rss", "Туркмения"],
    ["https://news.yandex.ru/Uzbekistan/index.rss", "Узбекистан"],
    ["https://news.yandex.ua/index.rss", "Украина"]
  ]
)

HOROSCOPE_CATEGORIES = %w(БЛИЗНЕЦЫ ВЕСЫ ВОДОЛЕЙ ДЕВА КОЗЕРОГ ЛЕВ ОВЕН РАК
                          РЫБЫ СКОРПИОН СТРЕЛЕЦ ТЕЛЕЦ)
TEAM = HashWithIndifferentAccess.new(
  "andrei": { name: "глупый" },
  "serghei": { name: "важный" },
  "greta": { name: "черно-белая-белка" },
  "masha": { name: "думает о пирожках" },
  "oleg": { name: "директор" },
  "nastya": { name: "лисенак" },
  "sasha": { name: "друг глупого" },
  "bond": { name: "Bond... James Bond" }
)
