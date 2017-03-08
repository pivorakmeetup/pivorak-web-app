require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module PivorakWebApp
  class Application < Rails::Application
    config.version   = '0.9'
    config.time_zone = 'Kyiv'
    config.active_job.queue_adapter = :sidekiq
  end
end
