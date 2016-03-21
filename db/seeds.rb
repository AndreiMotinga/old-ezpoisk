# require 'csv'
#
# STATES.each { |s| State.create(name: s.first) }
#
# # create cities
# csv_text = File.read("public/us_cities_and_states.csv")
# csv = CSV.parse(csv_text, headers: false)
# csv.each do |row|
#   line = row[0].split("|")
#   state_name = line[1].strip
#   state = State.find_by_name(state_name)
#   city_name = line[2].strip
#   City.create(name: city_name, state: state)
# end

Partner.create(
  user_id: 4,
  link: "/about",
  title: "Приветствие топ",
  position: "Вверху"
)
