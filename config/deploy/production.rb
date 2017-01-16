server '188.166.8.111', roles: %w{app db web}, user: 'pivorak'
set :branch, 'development'
set :deploy_to, proc { "/home/pivorak/projects/pivorak_#{fetch :stage}" }
