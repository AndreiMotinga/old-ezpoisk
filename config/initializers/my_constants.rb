SALE_CATEGORIES = %w(kids home pets clothes sale plants transportation  electronics).freeze
SALE_TYPES = %w(selling buying giving)
JOB_CATEGORIES = %w(wanted seeking).freeze
PARTNER_POSITIONS = %w(left right).freeze

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
              computers confectioners nannies tranlations parcels advertisement
              restourants funeral-services sports escort insurance tourism
              dance cleaning finances-taxes photo-video art flowers
              erotics-massage psychic)
).freeze

# remove
STATES = [
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

STRIPE_PLANS = [
  {
    stripe_id: :monthly_base,
    name: "EZPOISK Base Plan",
    select_name: "EZPOISK Base Plan ($99, priority 1)",
    currency: "usd",
    amount: 9900,
    total: 9900,
    priority: 1,
    interval_count: 1,
    interval: "month"
  },
  {
    stripe_id: :monthly_standart,
    name: "EZPOISK Standart Plan",
    select_name: "EZPOISK Standart Plan ($249, priority 2)",
    currency: "usd",
    amount: 249_00,
    total:  249_00,
    priority: 2,
    interval_count: 1,
    interval: "month"
  },
  {
    stripe_id: :monthly_premium,
    name: "EZPOISK Premium Plan",
    select_name: "EZPOISK Premium Plan ($599, priority 3)",
    currency: "usd",
    amount: 599_00,
    total: 599_00,
    priority: 3,
    interval_count: 1,
    interval: "month"
  }
].freeze
