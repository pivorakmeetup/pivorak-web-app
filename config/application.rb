require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module PivorakWebApp
  class Application < Rails::Application
    config.version   = '1.1.1'
    config.time_zone = 'Kyiv'
    config.autoload_paths << Rails.root.join('lib')
  end
end
