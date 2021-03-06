# Server Options
# ===================
server 'stage-app.k2practice.com', user: 'deploy', roles: %w{app db web}
set :deploy_to, '/home/deploy/stage-util'

# Environment Options
# ===================
set :branch, 'staging'
set :stages, 'staging'
set :rails_env, 'staging'

# Build Options
# ===================
set :bundle_without, (fetch(:bundle_without, []) - %w(staging)).join(' ')

# Custom SSH Options
# ===================
set :ssh_options, {
  keys: %w(~/.ssh/id_rsa),
  forward_agent: true,
  auth_methods: %w(publickey)
}
