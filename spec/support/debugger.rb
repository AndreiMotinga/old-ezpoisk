RSpec.configure do |config|
  config.around(:each) do |example|
    result = example.run
    if result.is_a?(Exception)
      puts "Debugging enabled"
      binding.pry
    end
  end
end
