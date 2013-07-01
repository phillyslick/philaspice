require "bundler/capistrano"


server "198.211.100.11:21521", :web, :app, :db, primary: true

set :application, "philaspice"
set :user, "slick"
set :deploy_to, "/home/#{user}/apps/#{application}"
set :deploy_via, :remote_cache
set :use_sudo, false

set :scm, "git"
set :repository, "git@github.com:phillyslick/#{application}.git"
set :branch, "master"
set :shared_children, shared_children + %w{public/uploads}
set :shared_children, shared_children + %w{config/settings}

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

after "deploy", "deploy:cleanup" # keep only the last 5 releases


namespace :deploy do
  %w[start stop restart].each do |command|
    desc "#{command} unicorn server"
    task command, roles: :app, except: {no_release: true} do
      run "#{sudo} service nginx #{command}"
      run "/etc/init.d/unicorn_#{application} #{command}"
    end
  end
  
  task :setup_config, roles: :app do
    sudo "ln -nfs #{current_path}/config/nginx.conf /etc/nginx/sites-enabled/#{application}"
    sudo "ln -nfs #{current_path}/config/unicorn_init.sh /etc/init.d/unicorn_#{application}"
    run "mkdir -p #{shared_path}/config"
    run "mkdir -p #{shared}/config/settings"
    run "mkdir -p #{shared_path}/public/uploads"
    run "mkdir -p #{shared_path}/public/fallback"
    put File.read("config/database.example.yml"), "#{shared_path}/config/database.yml"
    put File.read("config/settings/production.yml"), "#{shared_path}/config/settings/production.yml"
    puts "Now edit the config files in #{shared_path}."
  end
  
  after "deploy:setup", "deploy:setup_config"

  task :symlink_config, roles: :app do
      run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end
  
  after "deploy:finalize_update", "deploy:symlink_config"

  desc "Make sure local git is in sync with remote."
  task :check_revision, roles: :web do
    unless `git rev-parse HEAD` == `git rev-parse origin/master`
      puts "WARNING: HEAD is not the same as origin/master"
      puts "Run `git push` to sync changes."
      exit
    end
  end
 # before "deploy", "deploy:check_revision"
end