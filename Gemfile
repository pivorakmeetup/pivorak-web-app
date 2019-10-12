# frozen_string_literal: true

source 'https://rubygems.org'

ruby '2.6.5'

#=== CORE =====================================================================
gem 'acts-as-taggable-on', git: 'https://github.com/Fodoj/acts-as-taggable-on', ref: 'rails-5.2'
gem 'carrierwave', '~> 1.2'
gem 'devise', '~> 4.7.1'
gem 'friendly_id', '~> 5.1'
gem 'kaminari'
gem 'omniauth-facebook', '~> 5.0'
gem 'omniauth-github', '~> 1.3.0'
gem 'omniauth-twitter', '~> 1.4.0'
gem 'pg', '~> 0.18'
gem 'pg_search', '~> 2.0'
gem 'puma', '~> 3.12'
gem 'rack-attack'
gem 'rails', '5.2.2.1'
gem 'redis', '~>3.2'
gem 'sidekiq'
gem 'sidekiq-scheduler', '~> 2.1.4'
gem 'simple_form'

gem 'courses', path: 'components/courses'
gem 'ez-settings'

#=== CONFIG ===================================================================
gem 'dotenv-rails', '~> 2.5', require: 'dotenv/rails-now'
gem 'newrelic_rpm',                                                    '~> 5.4'
gem 'rollbar',                                                         '~> 2.19.3'
gem 'slackistrano',                                                    '~> 3.1.1'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
gem 'versionomy', '~> 0.5.0'

#=== UI =======================================================================
gem 'autoprefixer-rails', '~> 7.1.6'
gem 'coffee-rails', '~> 4.2.1'
gem 'jquery-rails', '~> 4.2.2'
gem 'premailer-rails' # email inline styling
gem 'rails-assets-semantic-ui-calendar', source: 'https://rails-assets.org'
gem 'rails-assets-svgxuse', source: 'https://rails-assets.org'
gem 'sass-rails', '~> 5.0'
gem 'semantic-ui-sass', '~> 2.2'
gem 'slim-rails'
gem 'turbolinks', '~> 5.2'
gem 'uglifier', '~> 4.1.19'
#=== FEATURES ==================================================================
gem 'chartkick', '~> 3.2.0'
gem 'coderay', '~> 1.1.1'
gem 'dry-validation', '~> 0.12.2'
gem 'gibbon', '~> 3.0'
gem 'groupdate', '~> 4.0'
gem 'httpclient', '~> 2.8.3'
gem 'icalendar', '~> 2.5.0'
gem 'inline_svg', '~> 1.2'
gem 'interactor-rails', '~> 2.0'
gem 'oj', '~> 3.7.11'
gem 'prawn-qrcode'
gem 'rails_email_preview', '~> 2.0.1'
gem 'recaptcha', require: 'recaptcha/rails'
gem 'redcarpet', '~> 3.4.0'
gem 'sitemap_generator', '~> 6.0.2'
gem 'stripe', '~> 1.5'
gem 'yt', '~> 0.32.2'
gem 'slack-notifier', '~> 2.3.2'
gem 'factory_bot_rails'

#=== PDF GENERATION ===========================================================
gem 'prawn'
gem 'prawn-table'

#=== DEV & TEST ===============================================================
group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'brakeman'
  gem 'capistrano', '~> 3.6'
  gem 'capistrano-rails', '~> 1.2'
  gem 'capistrano-rvm'
  gem 'capistrano-sidekiq'
  gem 'letter_opener'
  gem 'listen'
  gem 'meta_request'
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'spring-watcher-listen'
  gem 'web-console'
end

group :development, :test do
  gem 'bullet'
  gem 'capistrano3-postgres', require: false
  gem 'faker'
  gem 'guard-rspec'
  gem 'pry-rails'
  gem 'rspec'
  gem 'rspec-rails'
  gem 'rubocop', require: false
  gem 'rubocop-rspec'
  gem 'rubocop-faker'
end

group :test do
  gem 'capybara'
  gem 'climate_control'
  gem 'codecov', require: false
  gem 'database_cleaner'
  gem 'launchy'
  gem 'pdf-inspector', require: 'pdf/inspector'
  gem 'rspec-activemodel-mocks'
  gem 'rspec-collection_matchers'
  gem 'rspec-its'
  gem 'shoulda-matchers'
  gem 'simplecov', require: false
  gem 'stripe-ruby-mock', '~> 2.3.1', require: 'stripe_mock'
  gem 'timecop'
  gem 'webmock'
end
