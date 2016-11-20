RSpec.configure do |config|
  config.before(:each) do
    Timecop.freeze(Time.now)
  end

  config.after(:each) do
    Timecop.return
  end
end
