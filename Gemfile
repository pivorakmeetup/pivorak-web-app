source 'https://rubygems.org'

ruby '2.3.1'

#=== CORE =======================================
gem 'rails',                           '~> 5.0.1'
gem 'pg',                               '~> 0.18'
gem 'puma',                              '~> 3.0'

#=== UI =========================================
gem 'sass-rails',                        '~> 5.0'
gem 'turbolinks',                        '~> 5.0'
gem 'slim-rails',                        '~> 3.1'
gem 'jquery-rails',                    '~> 4.2.2'
gem 'semantic-ui-sass',              '~> 2.2.7.1'

#=== FEATUES ====================================
gem 'chartkick'
gem 'devise'
gem 'groupdate'
gem 'stripe'
gem 'pg_search'
gem 'interactor-rails',                  '~> 2.0'
gem 'omniauth-facebook'
gem 'omniauth-github'
gem 'omniauth-twitter'
gem 'simple_form',                       '~> 3.3'
gem 'sitemap_generator'
gem 'friendly_id',                       '~> 5.1'
gem 'kaminari',                         '~> 0.17'
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
gem 'httpclient'
gem 'oj' # faster json parser
gem 'rollbar'
gem 'uglifier'
# sidekiq
gem 'sidekiq'
gem 'sinatra', '>= 2.0.0.beta2', require: false
gem 'carrierwave', '~> 1.0'
gem 'acts-as-taggable-on',               '~> 4.0'
gem 'dry-validation'

#=== DEV & TEST =================================
group :development do
  gem 'web-console'
  gem 'listen',                          '~> 3.0'
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'spring-watcher-listen',           '~> 2.0'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'meta_request'
  gem 'capistrano', '~> 3.6'
  gem 'capistrano-rails', '~> 1.2'
  gem 'capistrano-sidekiq'
  gem 'capistrano-rvm'
end

group :development, :test do
  gem 'rspec'
  gem 'rspec-rails'
  gem 'pry-rails'
  gem 'dotenv-rails'
  gem 'faker'
 gem 'bullet'
end

group :test do
  gem 'stripe-ruby-mock', '~> 2.3.1', :require => 'stripe_mock'
  gem 'rspec-collection_matchers'
  gem 'rspec-its'
  gem 'rspec-activemodel-mocks'
  gem 'shoulda-matchers'
  gem 'factory_girl_rails'
  gem 'capybara'
  gem 'database_cleaner'
  gem 'simplecov',                 require: false
  gem 'launchy'
  gem 'vcr'
  gem 'webmock'
  gem 'codecov', :require => false
end
