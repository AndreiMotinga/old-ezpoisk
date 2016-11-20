if ENV.fetch("COVERAGE", false)
  require "simplecov"

  if ENV["CIRCLE_ARTIFACTS"]
    dir = File.join(ENV["CIRCLE_ARTIFACTS"], "coverage")
    SimpleCov.coverage_dir(dir)
  end

  SimpleCov.start "rails"
end

require "webmock/rspec"

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    #todo remove
    expectations.syntax = :expect
  end

  config.mock_with :rspec do |mocks|
    #todo remove?
    mocks.syntax = :expect
    mocks.verify_partial_doubles = true
  end

  config.example_status_persistence_file_path = "tmp/rspec_examples.txt"
  config.order = :random
end

WebMock.disable_net_connect!(allow_localhost: true)
