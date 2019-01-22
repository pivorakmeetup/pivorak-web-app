source 'https://rubygems.org'

ruby '2.6.1'

#=== CORE =====================================================================
gem 'rails',                                                           '5.2.2'
gem 'pg',                                                              '~> 1.1.4'
gem 'puma',                                                            '~> 3.12'
gem 'pg_search',                                                       '~> 2.1.3'
gem 'devise',                                                          '~> 4.5'
gem 'omniauth-facebook',                                               '~> 5.0'
gem 'omniauth-github',                                                 '~> 1.3.0'
gem 'omniauth-twitter',                                                '~> 1.4.0'
gem 'simple_form'
gem 'friendly_id',                                                     '~> 5.2'
gem 'kaminari'
gem 'carrierwave',                                                     '~> 1.3'
gem 'acts-as-taggable-on', git: 'https://github.com/Fodoj/acts-as-taggable-on', ref: 'rails-5.2'
gem 'sidekiq'
gem 'sidekiq-scheduler',                                               '~> 3.0'
gem 'redis'
gem 'rack-attack'

gem 'ez-settings'
gem 'courses', path: 'components/courses'

#=== CONFIG ===================================================================
gem 'dotenv-rails',                                                   '~> 2.5', require: 'dotenv/rails-now'
gem 'slackistrano',                                                   '~> 3.8.3'
gem 'newrelic_rpm',                                                   '~> 5.7'
gem 'versionomy',                                                     '~> 0.5.0'
gem 'rollbar',                                                        '~> 2.18.2'
gem 'tzinfo-data',              platforms: [:mingw, :mswin, :x64_mingw, :jruby]

#=== UI =======================================================================
gem 'sass-rails',                                                     '~> 5.0'
gem 'turbolinks',                                                     '~> 5.2'
gem 'slim-rails'
gem 'jquery-rails',                                                   '~> 4.3'
gem 'semantic-ui-sass',                                               '~> 2.4'
gem 'autoprefixer-rails',                                             '~> 9.4.6'
gem 'coffee-rails',                                                   '~> 4.2'
gem 'uglifier',                                                       '~> 4.1.20'
gem 'rails-assets-svgxuse',                  source: 'https://rails-assets.org'
gem 'rails-assets-semantic-ui-calendar',     source: 'https://rails-assets.org'
gem 'premailer-rails' # email inline styling

#=== FEATURES ==================================================================
gem 'chartkick',                                                      '~> 3.0.2'
gem 'groupdate',                                                      '~> 4.1.1'
gem 'stripe',                                                         '~> 1.58'
gem 'interactor-rails',                                               '~> 2.2'
gem 'sitemap_generator',                                              '~> 6.0.2'
gem 'httpclient',                                                     '~> 2.8.3'
gem 'oj',                                                             '~> 3.7.8'
gem 'redcarpet',                                                      '~> 3.4.0'
gem 'rails_email_preview',                                            '~> 2.1.0'
gem 'dry-validation',                                                 '~> 0.12.2'
gem 'inline_svg',                                                     '~> 1.3.1'
gem 'icalendar',                                                      '~> 2.5.2'
gem 'yt',                                                             '~> 0.32.2'
gem 'gibbon',                                                         '~> 3.2.0'
gem 'coderay',                                                        '~> 1.1.2'
gem 'recaptcha', require: 'recaptcha/rails'
gem 'prawn-qrcode'

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
  gem 'rubocop',                                                      '~> 0.63.1', require: false
  gem 'rubocop-rspec'
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
  gem 'factory_bot_rails'
  gem 'capybara'
  gem 'database_cleaner'
  gem 'simplecov', require: false
  gem 'launchy'
  gem 'timecop'
  gem 'webmock'
  gem 'codecov', require: false
  gem 'pdf-inspector', require: 'pdf/inspector'
end
