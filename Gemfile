source 'https://rubygems.org'

ruby '2.3.1'

#=== CORE =======================================
gem 'rails',             '~> 5.0.0', '>= 5.0.0.1'
gem 'pg',                               '~> 0.18'
gem 'puma',                              '~> 3.0'

#=== UI =========================================
gem 'sass-rails',                        '~> 5.0'
gem 'turbolinks',                        '~> 5.0'
gem 'slim-rails',                        '~> 3.1'
gem 'jquery-rails'

#=== FEATUES ====================================
gem 'devise'
gem 'omniauth-facebook'
gem 'omniauth-github'
gem 'simple_form',                       '~> 3.3'
gem 'access-granted',                    '~> 1.1'
gem 'friendly_id',                       '~> 5.1'
gem 'kaminari',                         '~> 0.17'
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

#=== DEV & TEST =================================
group :development do
  gem 'web-console'
  gem 'listen',                          '~> 3.0'
  gem 'spring'
  gem 'spring-watcher-listen',           '~> 2.0'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'meta_request'
  gem 'bullet'
end

group :development, :test do
  gem 'rspec'
  gem 'rspec-rails'
  gem 'pry-rails'
  gem 'dotenv-rails'
end

group :test do
  gem 'faker'
  gem 'rspec-collection_matchers'
  gem 'rspec-its'
  gem 'rspec-activemodel-mocks'
  gem 'shoulda-matchers'
  gem 'factory_girl_rails'
  gem 'capybara'
  gem 'database_cleaner'
  gem 'simplecov',                 require: false
  gem 'launchy'
end
