# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'simplecov'
require 'sidekiq/testing'

if ENV['CI']
  require 'codecov'

  SimpleCov.formatter = SimpleCov::Formatter::Codecov
  SimpleCov.merge_timeout 1200 # 20 minutes
end

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)

Rails.application.load_tasks

# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?

require 'rspec/rails'
require 'capybara/rails'
require 'database_cleaner'
require 'rspec/collection_matchers'
require 'rspec/its'
require 'rspec/active_model/mocks'

Dir[Rails.root.join('spec/support/*.rb')].each { |f| require f }

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end

OmniAuth.config.test_mode = true

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  # Add factory girl
  config.include FactoryBot::Syntax::Methods

  config.include Warden::Test::Helpers
  config.before :suite do
    Warden.test_mode!
  end

  # config.filter_run           focus: true
  # config.filter_run_excluding skip:  true

  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!

  config.before(:suite) do |_|
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end

  include ActiveJob::TestHelper
  config.before(:each) do
    # Clears out the jobs for tests using the fake testing
    clear_enqueued_jobs
  end

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.include ActionView::TestCase::Behavior, type: :presenter
end
