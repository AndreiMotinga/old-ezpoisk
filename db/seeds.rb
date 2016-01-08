require 'csv'

User.create(email: 'test@test.com',
            password: 'password',
            password_confirmation: 'password',
            name: 'Andrei',
            phone: '9898989898',
            admin: true
           )

# create states
STATES.each { |s| State.create(name: s) }

# create cities
csv_text = File.read('public/us_cities_and_states.csv')
csv = CSV.parse(csv_text, :headers => false)
csv.each do |row|
  line = row[0].split('|')
  state_name = line[1].strip
  state = State.find_by_name(state_name)
  city_name = line[2].strip
  City.create(name: city_name, state: state)
end

