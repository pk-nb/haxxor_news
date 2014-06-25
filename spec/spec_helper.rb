ENV["RAILS_ENV"] ||= 'test'

require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'capybara/rails'

Dir[File.dirname(__FILE__) + '/helpers/*.rb'].each {|file| require file}

RSpec.configure do |config|
  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = :random
  config.use_transactional_fixtures = true
  config.include FactoryGirl::Syntax::Methods
  config.include UserCreateHelper
end
