require 'rapgenius'
require 'mocha/api'
require 'webmock/rspec'

Dir[File.expand_path('../support/**/*.rb', __FILE__)].each { |f| require f }

RSpec.configure do |config|
  config.mock_framework = :mocha
end
