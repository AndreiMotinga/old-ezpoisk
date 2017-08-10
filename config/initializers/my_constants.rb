SUBCATEGORIES = {
  "артисты-развлечения" => "артисты--развлечения",
  "бары-кафе-рестораны" => "бары--кафе--рестораны",
  "компьютеры-it" => "компьютеры--интернет",
  "няни-сиделки-домработницы" => "няни--сиделки--домработницы",
  "образование-учителя-воспитатели" => "образование--учителя--воспитатели",
  "продавцы-кассиры-администраторы" => "продавцы--кассиры--администраторы",
  "реклама-маркетинг" => "реклама--маркетинг",
  "cалоны-красоты-парикмахерские" => "cалоны-красоты--парикмахерские",
  "спорт-здоровье" => "спорт--здоровье",
  "дилеры-аукционы" => "дилеры--аукционы",
  "фото-видео-аудио" => "фото--видео--аудио",
  "аварии-медицинские-ошибки" => "аварии--медицинские-ошибки",
  "наследство-завещания" => "наследство--завещания",
  "салоны-красоты-парикмахерские" => "салоны-красоты--парикмахерские",
  "эпиляция-лазерная-косметология" => "эпиляция--лазерная-косметология",
  "медицинский-офис-госпиталь" => "медицинский-офис--госпиталь",
  "университеты-колледжы-школы" => "университеты--колледжы--школы",
  "танцы-музыка-искусство" => "танцы--музыка--искусство",
  "мастер-на-все-руки-handyman" => "мастер-на-все-руки--handyman",
  "сигнализация-видеонаблюдение" => "сигнализация--видеонаблюдение",
  "кондиционеры-отопление" => "кондиционеры--отопление",
  "книги-печатная-продукция" => "книги--печатная-продукция",
  "парфюмерия-и-косметика" => "парфюмерия--косметика",
  "ткани-и-товары-для-рукоделия" => "ткани--товары-для-рукоделия",
  "артисты-праздники" => "артисты--праздники",
  "бизнес-партнерства" => "бизнес--партнерства",
  "татуировка-татуаж" => "татуировка--татуаж",
  "детективы-охрана" => "детективы--охрана",
  "отдых-развлечения" => "отдых--развлечения",
  "няни-сиделки" => "няни--сиделки--домработницы",
  "переводы-печатные-работы" => "переводы--печатные-работы",
  "посылки-грузы" => "посылки--грузы",
  "реклама-и-pr" => "реклама--pr",
  "бухгалтеры-финансы-налоги" => "бухгалтеры--финансы-налоги",
  "фото-видео" => "фото--видео--аудио"
}

RP_SORT_OPTIONS = {
  "Сортировать": "",
  "Подешевле": "price asc",
  "Подороже": "case when price is null then -1 else price end desc",
  "Поменьше": "space asc",
  "Побольше": "space desc",
  "Поновее": "created_at desc"
}.freeze

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
      "переводчик",
      "персональный-помощник",
      "продавцы--кассиры--администраторы",
      "ремонт-техники",
      "ремонт-автомобилей",
      "реклама--маркетинг",
      "строительство",
      "cалоны--красоты-парикмахерские",
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
      "для-детей",
      "для-дома",
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
        "moving-грузоперевозки",
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
        "ремонт-настройка-музыкальных-инструментов"
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
        "детективы--охрана",
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
        "бухгалтеры-финансы-налоги",
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
