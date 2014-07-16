# Workers
worker_processes 2
working_directory "/home/cloudmemory/www/cloudmemory/current"

# This loads the application in the master process before forking
preload_app true
timeout 30

# This is where we specify the socket.
listen "/home/cloudmemory/www/cloudmemory/current/tmp/sockets/unicorn.sock", backlog: 1024
pid "/home/cloudmemory/www/cloudmemory/current/tmp/pids/unicorn.pid"

# Set the path of the log files inside the log folder of the testapp
stderr_path "/home/cloudmemory/www/cloudmemory/current/log/unicorn_stderr.log"
stdout_path "/home/cloudmemory/www/cloudmemory/current/log/unicorn_stdout.log"

before_exec do |server|
  ENV["BUNDLE_GEMFILE"] = "/home/cloudmemory/www/cloudmemory/current/Gemfile"
end

before_fork do |server, worker|
  # This option works in together with preload_app true setting
  # What is does is prevent the master process from holding
  # the database connection

  # Kill old copy of itself
  old_pid = '/home/cloudmemory/www/cloudmemory/current/tmp/pids/unicorn.pid.oldbin'
  if File.exists?(old_pid) && server.pid != old_pid
    begin
      Process.kill("QUIT", File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
      # someone else did our job for us
    end
  end
end

after_fork do |server, worker|
  # Here we are establishing the connection after forking worker
  # processes
end
