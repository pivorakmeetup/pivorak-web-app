# frozen_string_literal: true

# rubocop:disable all

# TODO: Hide this IP :)
server '188.166.8.111', roles: %w[app db web], user: 'pivorak'
set :branch, ENV.fetch('PRODUCTION_BRANCH', 'development')
set :deploy_to, proc { "/home/pivorak/projects/pivorak_#{fetch :stage}" }
set :user, 'pivorak'

# rubocop:enable all
