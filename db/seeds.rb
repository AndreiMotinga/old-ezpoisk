# require 'csv'
#
# STATES.each { |s| State.create(name: s.first) }
#
# # create cities
# csv_text = File.read("public/us_cities_and_states.csv")
# csv = CSV.parse(csv_text, headers: false)
# csv.each do |row|
#   line = row[0].split("|")
#   state_abbr = line[0].strip
#   state_name = line[1].strip
#   puts state_name
#   next if State.find_by_abbr(state_abbr)
#   state = State.find_by_name(state_name)
#   state.abbr = state_abbr
#   state.save
# end

# Partner.create(
#   user_id: 4,
#   link: "/about",
#   title: "Приветствие топ",
#   position: "Вверху"
# )




states = [
  %w(Alabama AL),
  %w(Alaska	AK),
  %w(Arizona	AZ),
  %w(Arkansas	AR),
  %w(California	CA),
  %w(Colorado	CO),
  %w(Connecticut	CT),
  %w(Delaware	DE),
  %w(Florida	FL),
  %w(Georgia	GA),
  %w(Hawaii	HI),
  %w(Idaho	ID),
  %w(Illinois	IL),
  %w(Indiana	IN),
  %w(Iowa	IA),
  %w(Kansas	KS),
  %w(Kentucky	KY),
  %w(Louisiana	LA),
  %w(Maine	ME),
  %w(Maryland	MD),
  %w(Massachusetts	MA),
  %w(Michigan	MI),
  %w(Minnesota	MN),
  %w(Mississippi	MS),
  %w(Missouri	MO),
  %w(Montana	MT),
  %w(Nebraska	NE),
  %w(Nevada	NV),
  [ "New Hampshire",	"NH" ],
  [ "New Jersey",	"NJ" ],
  [ "New Mexico",	"NM" ],
  [ "New York",	"NY" ],
  [ "North Carolina",	"NC" ],
  [ "North Dakota",	"ND" ],
  %w(Ohio,	OH),
  %w(Oklahoma	OK),
  %w(Oregon	OR),
  %w(Pennsylvania	PA),
  [ "Rhode Island",	"RI" ],
  [ "South Carolina",	"SC" ],
  [ "South Dakota",	"SD" ],
  %w(Tennessee	TN),
  %w(Texas	TX),
  %w(Utah	UT),
  %w(Vermont	VT),
  %w(Virginia	VA),
  %w(Washington	WA),
  %w("West Virginia",	"WV"),
  %w(Wisconsin	WI),
  %w(Wyoming	WY)
]
states.each do |state|
  State.create(
    :name => state.first,
    :abbr => state.last
  )
end

# Post.create(
#   title: "Внимание акция, 20% скидка на цветы",
#   description: "pLorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. ",
#   text: "pLorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. ",
# )
#
# Post.create(
#   title: "Професиональынй фотоограф, 20% скидка на цветы",
#   description: "pLorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. ",
#   text: "pLorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. ",
# )
# Post.create(
#   title: "Velvet Rope Lounge, супер крутая вечеринка",
#   description: "pLorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. ",
#   text: "pLorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. ",
# )

# Plan.create(
#   title: "basic_weekly",
#   name: "Basic Weekly Plan - $16/неделя",
#   amount: 16_00,
#   currency: "usd",
#   interval: "month"
# )
#
# Plan.create(
#   title: "basic_monthly",
#   name: "Basic Monthly Plan - $50/месяц",
#   amount: 50_00,
#   currency: "usd",
#   interval: "month"
# )
#
# Plan.create(
#   title: "basic_yearly",
#   name: "Basic Yearly Plan - $520/год",
#   amount: 520_00,
#   currency: "usd",
#   interval: "year"
# )

# Plan.create(
#   title: "business_monthly",
#   name: "Business Monthly Plan",
#   amount: 100_00,
#   currency: "usd",
#   interval: "month"
# )
#
# Plan.create(
#   title: "business_yearly",
#   name: "Business Yearly Plan",
#   amount: 960_00, # 80 a month
#   currency: "usd",
#   interval: "year"
# )
#
# Plan.create(
#   title: "golden_monthly",
#   name: "Golden Monthly Plan",
#   amount: 150_00,
#   currency: "usd",
#   interval: "month"
# )
#
# Plan.create(
#   title: "golden_yearly",
#   name: "Golden Yearly Plan",
#   amount: 1560_00, # 130 a month
#   currency: "usd",
#   interval: "year"
# )
