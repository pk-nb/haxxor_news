ENV["RAILS_ENV"] ||= 'test'

require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'capybara/rails'

Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
  ActiveRecord::Migration.maintain_test_schema!
  config.order = :random
  config.use_transactional_fixtures = false
  config.include FactoryGirl::Syntax::Methods
  config.include UserCreateHelper, type: :feature
  config.include FillLoginHelper, type: :feature
  config.include DatabaseCleanerHelper, :type => :feature
  config.include PasswordResetCreateHelper
end
