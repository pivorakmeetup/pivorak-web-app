# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)

require 'courses/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'courses'
  s.version     = Courses::VERSION
  s.authors     = ['Volodya Sveredyuk']
  s.email       = ['sveredyuk@gmail.com']
  s.homepage    = 'https://pivorak.com/'
  s.summary     = 'Courses extenstions'
  s.description = 'Courses extenstions'
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']

  s.add_dependency 'friendly_id'
  s.add_dependency 'kaminari'
  s.add_dependency 'rails'
  s.add_dependency 'simple_form'
  s.add_dependency 'slim-rails'

  s.add_development_dependency 'capybara'
  s.add_development_dependency 'factory_girl_rails'
  s.add_development_dependency 'faker'
  s.add_development_dependency 'guard-rspec'
  s.add_development_dependency 'launchy'
  s.add_development_dependency 'pry-rails'
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'simplecov'
  s.add_development_dependency 'sqlite3'
end
