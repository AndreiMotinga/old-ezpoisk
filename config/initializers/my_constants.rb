# frozen_string_literal: true
# remove - use chache instead
STATES = [
  ['Штат', ''                          ],
  [ 'Alabama', 'alabama'               ],
  [ 'Alaska', 'alaska'                 ],
  [ 'Arizona', 'arizona'               ],
  [ 'Arkansas', 'arkansas'             ],
  [ 'California', 'california'         ],
  [ 'Colorado', 'colorado'             ],
  [ 'Connecticut', 'connecticut'       ],
  [ 'DC', 'dc'                         ],
  [ 'Delaware', 'delaware'             ],
  [ 'Florida', 'florida'               ],
  [ 'Georgia', 'georgia'               ],
  [ 'Hawaii', 'hawaii'                 ],
  [ 'Idaho', 'idaho'                   ],
  [ 'Illinois', 'illinois'             ],
  [ 'Indiana', 'indiana'               ],
  [ 'Iowa', 'iowa'                     ],
  [ 'Kansas', 'kansas'                 ],
  [ 'Kentucky', 'kentucky'             ],
  [ 'Louisiana', 'louisiana'           ],
  [ 'Maine', 'maine'                   ],
  [ 'Maryland', 'maryland'             ],
  [ 'Massachusetts', 'massachusetts'   ],
  [ 'Michigan', 'michigan'             ],
  [ 'Minnesota', 'minnesota'           ],
  [ 'Mississippi', 'mississippi'       ],
  [ 'Missouri', 'missouri'             ],
  [ 'Montana', 'montana'               ],
  [ 'Nebraska', 'nebraska'             ],
  [ 'Nevada', 'nevada'                 ],
  [ 'New Hampshire', 'new-hampshire'   ],
  [ 'New Jersey', 'new-jersey'         ],
  [ 'New Mexico', 'new-mexico'         ],
  [ 'New York', 'new-york'             ],
  [ 'North Carolina', 'north-carolina' ],
  [ 'North Dakota', 'north-dakota'     ],
  [ 'Ohio', 'ohio'                     ],
  [ 'Oklahoma', 'oklahoma'             ],
  [ 'Oregon', 'oregon'                 ],
  [ 'Pennsylvania', 'pennsylvania'     ],
  [ 'Rhode Island', 'rhode-island'     ],
  [ 'South Carolina', 'south-carolina' ],
  [ 'South Dakota', 'south-dakota'     ],
  [ 'Tennessee', 'tennessee'           ],
  [ 'Texas', 'texas'                   ],
  [ 'Utah', 'utah'                     ],
  [ 'Vermont', 'vermont'               ],
  [ 'Virginia', 'virginia'             ],
  [ 'Washington', 'washington'         ],
  [ 'West Virginia', 'west-virginia'   ],
  [ 'Wisconsin', 'wisconsin'           ],
  [ 'Wyoming', 'wyoming'               ]
].freeze

# Listing types, categories, subcategories, duration, etc.
KINDS = HashWithIndifferentAccess.new(
  "jobs": {
    categories: %w(wanted seeking),
    subcategories: %w(
      autoservices drivers temporary formen journalism art
      computers medical real-estate nannies education office security
      factories advertisement restourants beauty-salons escort sports
      construction sales management finances-taxes other
    )
  },
  "real-estate": {
    categories: %w(leasing renting selling buying),
    subcategories: %w(apartment office sales industry parking other),
    duration: %w(monthly weekly daily hourly),
    rooms: %w(bed room studio 1-room 2-room 3-room 4-room 5-room)
  },
  "sales": {
    categories: %w(selling buying giving),
    subcategories: %w(
      kids home pets clothes plants transportation electronics other
    )
  },
  "services": {
    categories: %w(
      auto lawers beauty medical real-estate education work repairs
      construction stores other
    ),
      subcategories: {
      "auto": %w(
        car-rentals autoservices carwash auto-stores driver-schools
        auto-auction moving carservice
      ),
        "lawers": %w(
        general accidents business paralegal immigration criminal
        heritage real-estate family
      ),
        "beauty": %w(beauty-salons spa correction epilation tatoo sauna),
        "medical": %w(
        hospitals farmacies alternative-medicine veterinary-clinics
        allergist venereologist gynecologis dermotolog nutritionist
        immunologist cardiologist beautician ent chiropractor
        neurologist dentist oncologist orthopedist ophthalmologist
        pediatrician plastic-surgeon psychiatrist psychologist
        seksopatolog family-doctor therapist urologist surgeon
        physiotherapist endocrinologist
      ),
        "real-estate": %w(realtors financing),
        "education": %w(
        schools art-education kinder-gardens english-lessons
        teachers sport-schools training
      ),
        "work": %w(job-agencies),
        "repairs": %w(
        cellphone-repair computer-repair appliances-repair
        clothes-repais musical-instruments-repair-tuning
      ),
        "construction": %w(
        construction-companies electicians plumbers painters
        handymen furniture alarm-video-surveillance locks
        fences-welding garbage interior-design air-conditioning
      ),
        "stores": %w(
        kid-goods stores-with-delivery pet-stores online-stores
        stationery book-stores clothes-stores shoe-stores
        perfumes-cosmetics-stores gift-stores food garden
        fabric-craft-supplies household-goods flower-stores wathces
        jewlery car-parts
      ),
        "other": %w(
        artists-celebrities business detectives exterminators
        computers confectioners nannies tranlations parcels advertisement
        restourants funeral-services sports escort insurance tourism
        dance cleaning finances-taxes photo-video art flowers
        erotics-massage psychic other
      )
    }
  }
)


RU_KINDS = HashWithIndifferentAccess.new(
  "работа" => {
    "categories" => [
      "требуется",
      "ищу-работу"
    ],
    "subcategories" => [
      "автосервисы",
      "водители",
      "временная",
      "грузчики",
      "журналистика",
      "искусство",
      "компьютеры-it",
      "медицина",
      "недвижимость",
      "няни-сиделки",
      "образование",
      "офис",
      "охрана",
      "производства",
      "реклама-и-pr",
      "рестораны-развлечения",
      "салоны-красоты-парикмахерские",
      "сопровождение-на-встречах-и-отдыхе",
      "спорт-фитнес",
      "строительство",
      "продажи",
      "управление",
      "финансы-налоги",
      "другое"
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
      "офис",
      "продажи",
      "промышленность",
      "парковка",
      "другое"
    ],
    "duration" => [
      "помесячно",
      "понедельно",
      "посуточно",
      "почасово"
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
      "другое"
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
      "строительство",
      "магазины",
      "другое"
    ],
    "subcategories" => {
      "автоуслуги" => [
        "авто-в-аренду",
        "автосервисы",
        "автомойки",
        "автомагазины",
        "автошколы",
        "дилеры-аукционы",
        "moving-грузоперевозки",
        "такси-carservice"
      ],
      "адвокаты" => [
        "общий-профиль",
        "аварии-медицинские-ошибки",
        "бизнес-партнерства",
        "нотариальные-услуги",
        "иммиграция",
        "криминал",
        "наследство-завещания",
        "по-недвижимости",
        "семейное-право"
      ],
      "красота" => [
        "салоны-красоты-парикмахерские",
        "spa-солярий-массаж-уход-за-телом",
        "коррекция-фигуры-и-лица",
        "эпиляция-лазерная-косметология",
        "татуировка-татуаж",
        "бани-сауны"
      ],
      "медицина" => [
        "медицинский-офис-госпиталь",
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
        "университеты-колледжы-школы",
        "танцы-музыка-искусство",
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
        "ремонт-бытовой-техники-электроники",
        "ремонт-пошив-одежды-обуви",
        "ремонт-настройка-музыкальных-инструментов"
      ],
      "строительство" => [
        "строительные-компании",
        "электрики",
        "сантехники",
        "маляры",
        "мастер-на-все-руки-handyman",
        "изготовление-мебели",
        "сигнализация-видеонаблюдение",
        "замки",
        "заборы-сварка",
        "снос-зданий-мусор",
        "ремонт-и-дизайн-помещений",
        "кондиционеры-отопление"
      ],
      "магазины" => [
        "детские-товары",
        "магазины-с-доставкой",
        "зоотовары",
        "интернет-магазины",
        "канцелярские-товары",
        "книги-печатная-продукция",
        "одежда",
        "обувь",
        "парфюмерия-и-косметика",
        "подарки-сувениры",
        "продукты",
        "сад-и-огород",
        "ткани-и-товары-для-рукоделия",
        "хозтовары",
        "цветы",
        "часы",
        "ювелирные-изделия",
        "автозапчасти"
      ],
      "другое" => [
        "артисты-праздники",
        "бизнес-партнерства",
        "детективы-охрана",
        "истребление-насекомых",
        "компьютеры-it",
        "кондитеры",
        "няни-сиделки",
        "переводы-печатные-работы",
        "посылки-грузы",
        "реклама-и-pr",
        "рестораны-развлечения",
        "ритуальные-услуги",
        "спорт-фитнес",
        "сопровождение-на-встречах-и-отдыхе",
        "страхование",
        "туристические-фирмы",
        "танцы",
        "уборка-помещений",
        "финансы-налоги",
        "фото-видео",
        "искусство",
        "цветы",
        "эротический-массаж",
        "экстрасенсы",
        "другое"
      ]
    }
  }
)
