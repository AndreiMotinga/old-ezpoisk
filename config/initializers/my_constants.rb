SALE_CATEGORIES = %w(transportation home kids clothes electronics pets plants
                     sale).freeze
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
