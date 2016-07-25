# Ensure that bundle is used for rake tasks
SSHKit.config.command_map[:rake] = 'bundle exec rake'

# config valid only for current version of Capistrano
lock '3.5.0'

set :application, 'photos'
set :repo_url, 'git@github.com:aea7/Photos.git'
set :rails_env, 'production'
set :user, 'rails'
set :rvm_type, :system
set :deploy_via, :remote_cache
set :pty, true
set :ssh_options, forward_agent: true
set :use_sudo, false
set :bundle_binstubs, nil
set :keep_releases, 5

set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

## unicorn config
pid_file = '/home/rails/photos/shared/tmp/pids/unicorn.pid'
stop_command = "sudo kill -s QUIT `cat #{pid_file}`"

namespace :deploy do

  after 'deploy:publishing', 'deploy:restart'

  # namespace :deploy do
  #   task :restart do
  #     invoke 'unicorn:reload'
  #   end
  # end

  desc 'Restart nginx with unicorn'
  task :restart do
    on roles(:all) do
      execute! 'chmod +x /home/rails/photos/current/config/unicorn-init.sh'
      execute! :sudo, 'ln -sf /home/rails/photos/current/config/unicorn-init.sh /etc/init.d/unicorn'
      execute! "if [[ -f #{pid_file} ]]; then #{stop_command}; fi"
      sleep 2
      execute! :sudo, :service, :unicorn, :restart
      sleep 2
      execute! :sudo, :service, :nginx, :restart
    end
  end


  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

end
