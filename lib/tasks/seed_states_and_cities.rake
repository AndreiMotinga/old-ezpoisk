require "csv"

desc "Seeds db with states and cities"
namespace :db do
  task seed_states_and_cities: :environment do
    create_states
    create_cities
  end

  def create_states
    puts "Seeding States"
    STATES.each do |s|
      State.create(name: s.first)
    end
    puts "Done"
  end

  def create_cities
    puts "Seeding Cities"
    # csv = parse_csv
    # cities = create_cities_array(csv)
    # load_cities(cities)
    records = []
    old_state_name = ""
    state_id = nil
    parsed_csv.each do |row|
      line = row[0].split("|")

      new_state_name = line[1].strip
      if new_state_name != old_state_name
        old_state_name = new_state_name
        state_id = State.find_by_name(old_state_name).id
      end

      city_name = line.last.strip
      record = [state_id, city_name]
      puts record
      records << record
    end

    records.map! { |record| "('#{record.first}', '#{record.last}')" }
    sql = "INSERT INTO cities (state_id, name) VALUES #{records.join(', ')}"

    connection = ActiveRecord::Base.connection()
    connection.execute(sql)
    puts "Done"
  end

  def create_cities_array(csv)
  end

  def load_cities(cities)
  end

  def parsed_csv
    csv_text = File.read("public/us_cities_and_states.csv")
    CSV.parse(csv_text, headers: false)
  end
end

