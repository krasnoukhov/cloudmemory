require 'capistrano_colors'
require "rvm/capistrano"
default_run_options[:pty] = true

# Application
set   :application, "cloudmemory"
set   :project, "cloudmemory"
set   :domain, "cloudmemory.is"
set   :deploy_to, "/home/#{project}/www/#{project}/"
role  :web, domain

# Source
set   :scm, "git"
set   :repository, "git@github.com:krasnoukhov/#{project}.git"
set   :branch, "master"
set   :repository_cache, "git"
set   :deploy_via, :remote_cache
set   :user, "cloudmemory"

# Options
set   :use_sudo, false
set   :keep_releases, 1
set   :shared_children, shared_children + %w(tmp/sockets)
set   :rvm_ruby_string, "ruby-1.9.3@cloudmemory"
set   :rvm_type, :user

# Bundler
after "deploy:finalize_update", "bundler:install"
namespace :bundler do
  task :install, roles: :web do
    shared_dir = File.join(shared_path, "bundle")
    release_dir = File.join(current_release, ".bundle")
    run "mkdir -p #{shared_dir}; ln -s #{shared_dir} #{release_dir}" 
    run "cd #{current_release} && bundle install --without test"
  end
end

# Deployment
after "deploy:update", "deploy:cleanup"
namespace :deploy do
  # Restart
  task :start, roles: :web do 
    run "cd #{current_path} && source #{current_path}/.config && bundle exec unicorn -c #{current_path}/config/unicorn.rb -E production -D"
  end
  task :stop, roles: :web do 
    run "kill -s QUIT `cat #{current_path}/tmp/pids/unicorn.pid`; true"
  end
  task :reload, roles: :web do
    run "kill -s USR2 `cat #{current_path}/tmp/pids/unicorn.pid`; true"
  end
  task :restart, roles: :web do
    reload
  end
end
