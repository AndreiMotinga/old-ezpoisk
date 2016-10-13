# remove - use chache instead
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
