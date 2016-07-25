APP_PATH = '/home/rails/photos'
worker_processes 4
working_directory APP_PATH + '/current'
listen APP_PATH + '/current/tmp/sockets/iven.sock', backlog: 64
timeout 60
stderr_path APP_PATH + '/shared/log/unicorn.log'
stdout_path APP_PATH + '/shared/log/unicorn.log'
pid APP_PATH + '/shared/tmp/pids/unicorn.pid'
preload_app true
GC.respond_to?(:copy_on_write_friendly=) and
  GC.copy_on_write_friendly = true
check_client_connection false

before_fork do |server, worker|
  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.connection.disconnect!
end

after_fork do |server, worker|
  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.establish_connection
end
