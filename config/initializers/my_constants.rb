# frozen_string_literal: true

RP_SORT_OPTIONS = {
  "Сортировать": "",
  "Подешевле": "price asc",
  "Подороже": "case when price is null then -1 else price end desc",
  "Поновее": "created_at desc"
}

SALE_SORT_OPTIONS = {
  "Сортировать": "",
  "Подешевле": "price asc",
  "Подороже": "case when price is null then -1 else price end desc",
  "Поновее": "created_at desc"
}

RU_KINDS = HashWithIndifferentAccess.new(
  "работа" => {
    "categories" => [
      "требуется",
      "ищу-работу"
    ],
    "subcategories" => [
      "артисты--развлечения",
      "бары--кафе--рестораны",
      "водители",
      "грузчики",
      "искусство",
      "компьютеры--интернет",
      "массаж",
      "няни--сиделки--домработницы",
      "образование--учителя--воспитатели",
      "офис",
      "подработка",
      "переводчики",
      "персональный-помощник",
      "продавцы--кассиры--администраторы",
      "ремонт-установка-оборудования",
      "ремонт-автомобилей",
      "реклама--маркетинг",
      "строительство",
      "cалоны-красоты--парикмахерские",
      "спорт--здоровье",
      "танцовщицы",
      "уборка",
      "фото--видео--аудио",
      "другое-разное"
    ]
  },
  "недвижимость" => {
    "categories" => [
      "сдаю-в-аренду",
      "ищу-в-аренду",
      "продаю",
      "хочу-купить"
    ],
    "subcategories" => [
      "квартира",
      "коммерческая",
      "парковка",
      "другое-разное"
    ],
    "duration" => [
      "помесячно",
      "посуточно",
    ],
    "rooms" => [
      "место-в-комнате",
      "комната",
      "студия",
      "1-спальная",
      "2-спальная",
      "3-спальная",
      "4-спальная",
      "5-спальная"
    ]
  },
  "продажи" => {
    "categories" => [
      "продаю",
      "хочу-купить",
      "отдаю"
    ],
    "subcategories" => [
      "дети",
      "дом",
      "домашние-животные",
      "одежда",
      "растения",
      "транспорт",
      "электроника",
      "другое-разное"
    ]
  },
  "услуги" => {
    "categories" => [
      "автоуслуги",
      "адвокаты",
      "красота",
      "медицина",
      "недвижимость",
      "образование",
      "работа",
      "ремонт",
      "строительство--ремонт",
      "магазины",
      "другое-разное"
    ],
    "subcategories" => {
      "автоуслуги" => [
        "авто-в-аренду",
        "автосервисы",
        "автомойки",
        "автомагазины",
        "автошколы",
        "дилеры--аукционы",
        "грузоперевозки-moving",
        "такси-carservice"
      ],
      "адвокаты" => [
        "общий-профиль",
        "аварии--медицинские-ошибки",
        "бизнес--партнерства",
        "нотариальные-услуги",
        "иммиграция",
        "криминал",
        "наследство--завещания",
        "недвижимость",
        "семейное-право"
      ],
      "красота" => [
        "салоны-красоты--парикмахерские",
        "spa",
        "солярий",
        "массаж",
        "коррекция-фигуры-и-лица",
        "эпиляция--лазерная-косметология",
        "татуировка--татуаж"
      ],
      "медицина" => [
        "медицинский-офис--госпиталь",
        "аптеки",
        "альтернативная-медицина",
        "ветеринарные-клиники",
        "аллерголог",
        "венеролог",
        "гинеколог-акушер",
        "дермотолог",
        "диетолог",
        "иммунолог",
        "кардиолог",
        "косметолог",
        "лор",
        "мануальный-терапевт",
        "невролог",
        "стоматолог",
        "онколог",
        "ортопед",
        "офтальмолог",
        "педиатр",
        "пластический-хирург",
        "психиатр-нарколог",
        "психолог",
        "сексопатолог",
        "семейный-доктор",
        "терапевт",
        "уролог-андролог",
        "хирург-проктолог",
        "физиотерапевт-массажист-хиропрактор",
        "эндокринолог"
      ],
      "недвижимость" => [
        "агентства-недвижимости",
        "финансирование"
      ],
      "образование" => [
        "университеты--колледжы--школы",
        "танцы--музыка--искусство",
        "детские-сады",
        "курсы-английского",
        "репетиторы",
        "спортивные-школы",
        "специализированые-курсы"
      ],
      "работа" => [
        "агентства-по-трудоустройству"
      ],
      "ремонт" => [
        "ремонт-и-сервис-телефонов",
        "ремонт-компьютеров",
        "ремонт-бытовой-техники",
        "ремонт-пошив-одежды",
        "ремонт-обуви",
        "музыкальные инструменты"
      ],
      "строительство--ремонт" => [
        "строительные-компании",
        "электрики",
        "сантехники",
        "маляры",
        "мастер-на-все-руки--handyman",
        "изготовление-мебели",
        "сигнализация--видеонаблюдение",
        "замки",
        "заборы-сварка",
        "вывоз-мусора",
        "дизайн-помещений",
        "кондиционеры--отопление"
      ],
      "магазины" => [
        "автозапчасти",
        "детские-товары",
        "магазины-с-доставкой",
        "зоотовары",
        "канцелярские-товары",
        "книги--печатная-продукция",
        "одежда",
        "обувь",
        "парфюмерия--косметика",
        "подарки-сувениры",
        "продукты",
        "сад-и-огород",
        "ткани--товары-для-рукоделия",
        "хозтовары",
        "цветы",
        "ювелирные-изделия"
      ],
      "другое-разное" => [
        "артисты--праздники",
        "бизнес--партнерства",
        "бухгалтеры-финансы-налоги",
        "детективы--охрана",
        "дизайн",
        "истребление-насекомых",
        "компьютеры--интернет",
        "кондитеры",
        "няни--сиделки--домработницы",
        "отдых--развлечения",
        "переводы--печатные-работы",
        "посылки--грузы",
        "реклама--pr",
        "ритуальные-услуги",
        "спорт-фитнес",
        "сопровождение-на-встречах",
        "страхование",
        "туристические-фирмы",
        "танцы",
        "уборка-помещений",
        "фото--видео--аудио",
        "искусство",
        "цветы",
        "эротический-массаж",
        "экстрасенсы",
        "другое-разное"
      ]
    }
  }
)

CITY_TAGS = [
  "new-york",
  "los-angeles",
  "san-francisco"
]

VK_GROUPS = HashWithIndifferentAccess.new(
  "new-york": {
    id: 112797570,
    недвижимость: 33955066,
    работа: 33955064,
    продажи: 33955068,
    услуги: 33955067,
  }
)

FB_GROUPS = HashWithIndifferentAccess.new(
  "new-york": {
    groups: {
      информация: 113694059344745,
      недвижимость: 1755700501389776,
      работа: 3
    },
    pages: {
      информация: 113694059344745,
      недвижимость: 1755700501389776,
      работа: 3
    }
  }
)
