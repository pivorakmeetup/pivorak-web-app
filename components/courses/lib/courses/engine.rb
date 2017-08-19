require 'slim-rails'
require 'kaminari'
require 'simple_form'
require 'friendly_id'

module Courses
  class Engine < ::Rails::Engine
    initializer :append_migrations do |app|
      unless app.root.to_s.match(root.to_s)
        config.paths['db/migrate'].expanded.each do |p|
          app.config.paths['db/migrate'] << p
        end
      end
    end
  end
end
