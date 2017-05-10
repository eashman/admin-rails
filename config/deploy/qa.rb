# Server Options
# ===================
server 'qa-util.k2practice.com', user: 'deploy', roles: %w(app db web)
set :deploy_to, '/home/deploy/qa-util'

# Environment Options
# ===================
set :branch, 'qa'
set :stages, 'qa'
set :rails_env, 'qa'

# Build Options
# ===================
set :bundle_without, (fetch(:bundle_without, []) - %w(qa)).join(' ')

# Custom SSH Options
# ===================
set :ssh_options, {
  keys: %w(~/.ssh/id_rsa),
  forward_agent: true,
  auth_methods: %w(publickey)
}
