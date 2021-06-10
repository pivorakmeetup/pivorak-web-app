# frozen_string_literal: true

require 'slim-rails'
require 'kaminari'
require 'simple_form'
require 'friendly_id'
require 'carrierwave'

module Shop
  class Engine < ::Rails::Engine
    initializer :append_migrations do |app|
      unless app.root.to_s.match(root.to_s)
        config.paths['db/migrate'].expanded.each do |p|
          app.config.paths['db/migrate'] << p
        end
      end
    end

    initializer 'sample_engine.factories', after: 'factory_bot.set_factory_paths' do
      FactoryBot.definition_file_paths << File.expand_path('../../spec/factories', __dir__) if defined?(FactoryBot)
    end
  end
end
