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
).freeze
