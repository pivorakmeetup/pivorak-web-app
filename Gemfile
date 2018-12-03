source 'https://rubygems.org'

ruby '2.3.1'

#=== CORE =====================================================================
gem 'rails',                                                           '5.2.1.1'
gem 'pg',                                                              '~> 0.18'
gem 'puma',                                                            '~> 3.12'
gem 'pg_search',                                                       '~> 2.0'
gem 'devise',                                                          '~> 4.5'
gem 'omniauth-facebook',                                               '~> 5.0'
gem 'omniauth-github',                                                 '~> 1.3.0'
gem 'omniauth-twitter',                                                '~> 1.4.0'
gem 'simple_form'
gem 'friendly_id',                                                     '~> 5.1'
gem 'kaminari'
gem 'carrierwave',                                                     '~> 1.2'
gem 'acts-as-taggable-on',  git: 'https://github.com/Fodoj/acts-as-taggable-on', ref: 'rails-5.2'
gem 'sidekiq'
gem 'sidekiq-scheduler',                                               '~> 2.1.4'
gem 'redis',                                                           '~>3.2'
gem 'rack-attack'

gem 'ez-settings'
gem 'courses', path: 'components/courses'

#=== CONFIG ===================================================================
gem 'dotenv-rails',                       '~> 2.5', require: 'dotenv/rails-now'
gem 'slackistrano',                                                    '~> 3.1.1'
gem 'newrelic_rpm',                                                    '~> 5.4'
gem 'versionomy',                                                      '~> 0.5.0'
gem 'rollbar',                                                         '~> 2.18.0'
gem 'tzinfo-data',              platforms: [:mingw, :mswin, :x64_mingw, :jruby]

#=== UI =======================================================================
gem 'sass-rails',                                                      '~> 5.0'
gem 'turbolinks',                                                      '~> 5.2'
gem 'slim-rails'
gem 'jquery-rails',                                                  '~> 4.2.2'
gem 'semantic-ui-sass',                                                '~> 2.2'
gem 'autoprefixer-rails',                                          '~> 6.7.7.2'
gem 'coffee-rails',                                                  '~> 4.2.1'
gem 'uglifier',                                                      '~> 4.1.19'
gem 'rails-assets-svgxuse',                  source: 'https://rails-assets.org'
gem 'rails-assets-semantic-ui-calendar',     source: 'https://rails-assets.org'
gem 'premailer-rails' # email inline styling
#=== FEATURES ==================================================================
gem 'chartkick',                                                     '~> 3.0.1'
gem 'groupdate',                                                       '~> 4.0'
gem 'stripe',                                                          '~> 1.5'
gem 'interactor-rails',                                                '~> 2.0'
gem 'sitemap_generator',                                             '~> 6.0.1'
gem 'httpclient',                                                    '~> 2.8.3'
gem 'oj',                                                           '~> 3.6.11'
gem 'redcarpet',                                                     '~> 3.4.0'
gem 'rails_email_preview',                                           '~> 2.0.1'
gem 'dry-validation',                                               '~> 0.12.2'
gem 'inline_svg',                                                      '~> 1.2'
gem 'icalendar',                                                     '~> 2.5.0'
gem 'yt',                                                           '~> 0.32.2'
gem 'gibbon',                                                          '~> 3.0'
gem 'coderay',                                                       '~> 1.1.1'
gem "recaptcha", require: "recaptcha/rails"
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
  gem 'rubocop',                                    '~> 0.59.2', require: false
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
