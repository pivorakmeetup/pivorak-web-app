source 'https://rubygems.org'

ruby '2.3.1'

#=== CORE =====================================================================
gem 'rails',                                                         '~> 5.0.2'
gem 'pg',                                                             '~> 0.18'
gem 'puma',                                                            '~> 3.0'
gem 'pg_search',                                                       '~> 2.0'
gem 'devise',                                                          '~> 4.2'
gem 'omniauth-facebook',                                               '~> 4.0'
gem 'omniauth-github',                                               '~> 1.2.3'
gem 'omniauth-twitter',                                              '~> 1.4.0'
gem 'simple_form',                                                     '~> 3.4'
gem 'friendly_id',                                                     '~> 5.1'
gem 'kaminari',                                                       '~> 0.17'
gem 'carrierwave',                                                     '~> 1.0'
gem 'acts-as-taggable-on',                                             '~> 4.0'
gem 'sidekiq',                                                      '~> 4.2.10'
gem 'sidekiq-scheduler',                                             '~> 2.1.4'
gem 'redis',                                                            '~>3.2'

gem 'ez-settings'

#=== UI =======================================================================
gem 'sass-rails',                                                      '~> 5.0'
gem 'turbolinks',                                                      '~> 5.0'
gem 'slim-rails',                                                      '~> 3.1'
gem 'jquery-rails',                                                  '~> 4.2.2'
gem 'semantic-ui-sass',                                                '~> 2.2'
gem 'autoprefixer-rails',                                          '~> 6.7.7.2'
gem 'coffee-rails',                                                  '~> 4.2.1'
gem 'uglifier',                                                      '~> 3.2.0'
gem 'rails-assets-svgxuse',                  source: 'https://rails-assets.org'
gem 'rails-assets-lory',                     source: 'https://rails-assets.org'
gem 'rails-assets-semantic-ui-calendar',     source: 'https://rails-assets.org'

#=== FEATURES ==================================================================
gem 'chartkick',                                                     '~> 2.2.3'
gem 'groupdate',                                                       '~> 3.2'
gem 'stripe',                                                          '~> 1.5'
gem 'liqpay',                         git: 'https://github.com/liqpay/sdk-ruby'
gem 'interactor-rails',                                                '~> 2.0'
gem 'sitemap_generator',                                             '~> 5.3.1'
gem 'httpclient',                                                    '~> 2.8.3'
gem 'oj',                                                           '~> 2.18.5'
gem 'redcarpet',                                                     '~> 3.4.0'
gem 'rails_email_preview',                                           '~> 2.0.1'
gem 'dry-validation',                                               '~> 0.10.5'
gem 'inline_svg',                                                      '~> 1.2'
gem 'icalendar',                                                     '~> 2.4.1'
gem 'yt',                                                           '~> 0.30.1'
gem 'gibbon',                                                          '~> 3.0'
gem 'coderay',                                                       '~> 1.1.1'

#=== CONFIG ===================================================================
gem 'dotenv-rails',                                                    '~> 2.2'
gem 'slackistrano',                                                  '~> 3.1.1'
gem 'newrelic_rpm',                                                    '~> 4.1'
gem 'versionomy',                                                    '~> 0.5.0'
gem 'rollbar',                                                      '~> 2.14.1'
gem 'tzinfo-data',              platforms: [:mingw, :mswin, :x64_mingw, :jruby]

#=== PDF GENERATION ===========================================================
gem 'prawn'
gem 'prawn-table'

#=== DEV & TEST ===============================================================
group :development do
  gem 'letter_opener'
  gem 'web-console'
  gem 'listen'
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'spring-watcher-listen'
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
  gem 'rubocop', require: false
  gem 'rspec-rails'
  gem 'pry-rails'
  gem 'faker'
  gem 'bullet'
  gem 'capistrano3-postgres', require: false
  gem 'guard-rspec'
end

group :test do
  gem 'stripe-ruby-mock', '~> 2.3.1', require: 'stripe_mock'
  gem 'rspec-collection_matchers'
  gem 'rspec-its'
  gem 'rspec-activemodel-mocks'
  gem 'shoulda-matchers'
  gem 'factory_girl_rails'
  gem 'capybara'
  gem 'database_cleaner'
  gem 'simplecov', require: false
  gem 'launchy'
  gem 'vcr'
  gem 'webmock'
  gem 'codecov', require: false
  gem 'pdf-inspector', require: 'pdf/inspector'
end
