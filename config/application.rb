require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

# Rectify loading conflict
require_relative '../app/models/application_record'
require_relative '../app/models/goal'
require_relative '../app/models/donation'
require_relative '../app/models/concerns/publishable'
require_relative '../app/models/talk'

module PivorakWebApp
  class Application < Rails::Application
    config.version = 'alpha'
    config.time_zone = 'Kyiv'
  end
end
