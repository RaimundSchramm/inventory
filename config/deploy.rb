require 'rvm/capistrano'

set :application, 'inventory'

server            '192.168.178.25', :web, :app, :db, primary: true
set :user,        'mund'
set :deploy_to,   "~/projects/#{application}"
set :use_sudo,    false
# default_run_options[:pty] = true
# ssh_options[:forward_agent] = true

set :scm, :git
# set :repository,  "set your repository location here"
set :deploy_via,  :remote_cache

after "deploy:restart", "deploy:cleanup"
