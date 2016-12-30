# config valid only for current version of Capistrano
lock "3.7.1"

set :application, proc { "pivorak-web-app_#{fetch :stage}" }
set :repo_url, 'git@github.com:pivorakmeetup/pivorak-web-app.git'
set :deploy_to, proc { "/home/dev/projects/pivorak_#{fetch :stage}" }
set :rvm_ruby_version, 'ruby-2.3.1@pivorak'
#set :linked_files, %w(config/database.yml config/secrets.yml .env)
set :linked_files, %w(config/database.yml config/secrets.yml .env)
set :linked_dirs, fetch(:linked_dirs, []).push(
  'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system',
  'node_modules'
)
set :user, 'dev'

set :rvm_map_bins, fetch(:rvm_map_bins, []).push('rvmsudo')

namespace :foreman do
  desc "Export the Procfile to Ubuntu's upstart scripts"
  task :export do
    on roles(:app), in: :sequence, wait: 5 do
      execute :rvmsudo, :foreman,
              'export',
              'upstart',
              '/etc/init',
              '-a', "#{fetch :application}",
              '-u', fetch(:user),
              '-l', shared_path.join('log'),
              '-e', shared_path.join('.env'),
              '-f', shared_path.join('Procfile'),
              '-d', release_path
    end
  end
end

namespace :deploy do
  desc 'Restart application'
  task :restart_application do
    on roles(:app), in: :sequence, wait: 5 do
      unless test :sudo, :start,   "#{fetch :application}"
        execute :sudo, :restart, "#{fetch :application}"
      end
    end
  end

#  before 'deploy:updated'
#  before 'deploy:compile_assets', 'webpack:build'

  after :publishing, 'foreman:export'
  after :publishing, 'restart_application'

end

