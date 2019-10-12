# frozen_string_literal: true

# rubocop:disable all

require 'dotenv/load'
# config valid only for current version of Capistrano
lock '3.11.0'

set :application, proc { "pivorak-web-app_#{fetch :stage}" }
set :repo_url, 'git@github.com:pivorakmeetup/pivorak-web-app.git'
set :deploy_to, proc { "/home/dev/projects/pivorak_#{fetch :stage}" }
set :rvm_ruby_version, 'ruby-2.6.5@pivorak'
# set :linked_files, %w(config/database.yml config/secrets.yml .env)
set :linked_files, %w[config/database.yml config/secrets.yml .env config/settings.yml]
set :linked_dirs, fetch(:linked_dirs, []).push(
  'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system',
  'node_modules', 'public/uploads'
)
set :user, 'dev'
set :ssh_options, keys: ['config/deploy_id_rsa'] if File.exist?('config/deploy_id_rsa')

set :rvm_map_bins, fetch(:rvm_map_bins, []).push('rvmsudo')

set :rollbar_token, ENV['rollbar_TOKEN']
set :rollbar_env, proc { fetch :stage }
set :rollbar_role, proc { :app }

set :postgres_remote_cluster, '9.6/main'
set :postgres_backup_compression_level, 6 # Will use gzip level 6 to compress the output.

namespace :foreman do
  desc "Export the Procfile to Ubuntu's upstart scripts"
  task :export do
    on roles(:app), in: :sequence, wait: 5 do
      execute :rvmsudo, :foreman,
              'export',
              'upstart',
              '/etc/init',
              '-a', (fetch :application).to_s,
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
      execute :sudo, :restart, (fetch :application).to_s unless test :sudo, :start, (fetch :application).to_s
    end
  end

  #  before 'deploy:updated'
  #  before 'deploy:compile_assets', 'webpack:build'

  after :publishing, 'foreman:export'
  after :publishing, 'restart_application'
end

# rubocop:enable all
