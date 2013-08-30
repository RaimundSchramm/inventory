require 'rvm/capistrano'
require 'bundler/capistrano'

set :application,             'inventory'

server                        '192.168.178.25', :web, :app, :db, primary: true
set :user,                    'mund'
set :deploy_to,               "/home/#{user}/projects/#{application}"
set :use_sudo,                false
default_run_options[:pty] =   true
ssh_options[:forward_agent] = true
set :rvm_ruby_string,         :local

set :bundle_dir,              ''
set :bundle_flags,            '--system --quiet'

set :scm,                     :git
# set :branch, 'master'
set :repo_path,               '/home/mund/repos/inventory.git'
set :repository,              "#{user}@192.168.178.25:#{repo_path}"
set :deploy_via,              :remote_cache

set :keep_releases,           1

namespace :deploy do
  task :setup_config, roles: :app do
    run "mkdir -p #{shared_path}/config"
    put File.read("config/database.production.sample.yml"), "#{shared_path}/config/database.yml"
    puts "Now edit the config files in #{shared_path}"
  end

  task :symlink_database_yml, roles: :app do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end
  after "deploy:finalize_update", "deploy:symlink_database_yml"

  task :start, roles: :app, except: { no_release: true } do
    run "cd #{current_path} && bundle exec thin -d -e production start -p 3068"
  end

  task :stop, roles: :app, except: { no_release: true } do
    run "cd #{current_path} && bundle exec thin -d -e production stop"
  end

  task :restart, :roles => :app, :except => { :no_release => true } do
    stop
    start
  end
end

after "deploy", "deploy:cleanup"
