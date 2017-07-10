$:.push File.expand_path("../lib", __FILE__)

require 'courses/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "courses"
  s.version     = Courses::VERSION
  s.authors     = ['Volodya Sveredyuk']
  s.email       = ['sveredyuk@gmail.com']
  s.homepage    = 'https://pivorak.com/'
  s.summary     = 'Courses extenstions'
  s.description = 'Courses extenstions'
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']

  s.add_dependency 'rails',          '~> 5.0.2'
  s.add_dependency 'slim-rails',     '~> 3.1'

  s.add_development_dependency 'sqlite3'
end
