# Server Options
# ===================
server 'int-util.k2practice.com', user: 'deploy', roles: %w(app db web)
set :deploy_to, '/home/deploy/int-util'

# Environment Options
# ===================
set :branch, 'int'
set :stages, 'int'
set :rails_env, 'int'

# Build Options
# ===================
set :bundle_without, (fetch(:bundle_without, []) - %w(int)).join(' ')

# Custom SSH Options
# ===================
set :ssh_options, {
  keys: %w(~/.ssh/id_rsa),
  forward_agent: true,
  auth_methods: %w(publickey)
}
