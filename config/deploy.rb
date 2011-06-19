set :application, "bernergarde"
set :scm, :git
set :repository,  "git@github.com:nickh/bernergarde.git"
set :deploy_via, :remote_cache
set :use_sudo, false

server "nicreation.hengeveld.com", :app, :web, :db, :primary => true

# Deploy rules for Passenger
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

namespace :deploy do
  desc "Run bundler command for installing gems"
  task :bundler, :roles => :app do
    run "cd #{current_path}; bundle install --without=development test"
  end
end
after("deploy:update_code", "deploy:bundler")

# There is no database.yml in source control; use the file in the deploy shared dir
after "deploy:update_code", "db:symlink"
namespace :db do
  desc 'Make symlink for deployed configuration files'
  task :symlink do
    run "ln -nsf #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end
end

set :deploy_to, "/home/nickh/apps/bernergarde"

# taken from http://rvm.beginrescueend.com/integration/capistrano/
set :rvm_type, :user                       # we have RVM in home dir, not system-wide install
$:.unshift("#{ENV["HOME"]}/.rvm/lib")      # Add RVM's lib directory to the load path.
require "rvm/capistrano"                   # Load RVM's capistrano plugin.
set :rvm_ruby_string, 'ruby-1.9.2@rails30' # Or whatever env you want it to run in.
