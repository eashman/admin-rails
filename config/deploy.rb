set :application, 'util'
set :repo_url, 'git@github.com:k2p-ed/util.git'

set :rvm_ruby_version, '2.3.1@util'

# Default value for :pty is false
set :pty, true

# Default value for :linked_files is []
set :linked_files, fetch(:linked_files, []).push('config/puma.rb')
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'config/keys', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

# Default value for :bundle_without is 'development test'
set :bundle_without, %w(development test)

# Puma config
set :puma_init_active_record, true

# After hooks
after 'deploy:published', 'bundler:clean'
