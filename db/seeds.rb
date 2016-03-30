# require 'csv'
#
# STATES.each { |s| State.create(name: s.first) }
#
# # create cities
csv_text = File.read("public/us_cities_and_states.csv")
csv = CSV.parse(csv_text, headers: false)
csv.each do |row|
  line = row[0].split("|")
  state_abbr = line[0].strip
  state_name = line[1].strip
  puts state_name
  next if State.find_by_abbr(state_abbr)
  state = State.find_by_name(state_name)
  state.abbr = state_abbr
  state.save
end

# Partner.create(
#   user_id: 4,
#   link: "/about",
#   title: "Приветствие топ",
#   position: "Вверху"
# )
