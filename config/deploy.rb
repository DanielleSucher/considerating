require 'bundler/capistrano'
set :user, 'danielles'
set :domain, 'considerating.daniellesucher.com'
set :applicationdir, "/"

set :application, "Considerating"
set :repository,  "set your repository location here"

set :scm, 'git'
set :repository,  "ssh://git@github.com:DanielleSucher/considerating.git"
set :branch, 'master'
set :git_shallow_clone, 1
set :scm_verbose, true

# roles (servers)
role :web, domain # Your HTTP server, Apache/etc
role :app, domain # This may be the same as your `Web` server
role :db,  domain, :primary => true # This is where Rails migrations will run

# deploy config
set :deploy_to, applicationdir
set :deploy_via, :export
 
# additional settings
default_run_options[:pty] = true  # Forgo errors when deploying from windows
#ssh_options[:keys] = %w(/home/user/.ssh/id_rsa)  



# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end