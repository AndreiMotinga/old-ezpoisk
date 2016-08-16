File.open('keywords/keywords.txt', 'w+') do |f|
  keys.each do |key|
    cities.each do |city|
      f.puts "#{key} #{city}"
      f.puts "'#{key} #{city}'"
      f.puts "[#{key} #{city}]"
    end
  end
end
