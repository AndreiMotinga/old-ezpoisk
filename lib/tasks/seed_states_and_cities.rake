require "csv"

desc "Seeds db with states and cities"
namespace :db do
  task load: :environment do
    create_states
    create_cities
    puts "All Done"
    puts "States: #{State.count}"
    puts "Cities: #{City.count}"
  end

  def create_states
    puts "Seeding States"
    STATES.each { |s| State.create(name: s.first) }
    State.find_each{|s| s.update_column(:slug, s.name.to_slug.normalize.to_s) }
  end

  def create_cities
    puts "Seeding Cities"
    csv = parsed_csv
    cities = create_cities_array(csv)
    load_cities(cities)
  end

  def create_cities_array(csv)
    state_name = ""
    state_id = nil
    parsed_csv.each_with_object([]) do |row, cities|
      new_state_name = state_name_from(row)
      city_name = city_name_from(row)
      city_slug = city_name.to_slug.normalize.to_s

      if new_state_name != state_name
        state_name = new_state_name
        state_id = State.find_by_name(state_name).id
      end

      cities << [state_id, city_name, city_slug]
    end
  end

  def state_name_from(row)
    line = row[0].split("|")
    line[1].strip
  end

  def city_name_from(row)
    line = row[0].split("|")
    line.last.strip
  end

  def load_cities(cities)
    cities.map! { |record| "('#{record[0]}', '#{record[1]}', '#{record[2]}')" }
    sql = "INSERT INTO cities (state_id, name, slug) VALUES #{cities.join(', ')}"
    connection = ActiveRecord::Base.connection()
    connection.execute(sql)
  end

  def parsed_csv
    csv_text = File.read("public/us_cities_and_states.csv")
    CSV.parse(csv_text, headers: false)
  end
end
