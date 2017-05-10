# Server Options
# ===================
server 'app1.k2practice.com', user: 'deploy', roles: %w(app db web)
server 'app2.k2practice.com', user: 'deploy', roles: %w(app db web)
set :deploy_to, '/home/deploy/prod-util'

# Environment Options
# ===================
set :branch, 'master'
set :stages, 'production'
set :rails_env, 'production'

# Build Options
# ===================
set :bundle_without, (fetch(:bundle_without, []) - %w(production)).join(' ')

# Custom SSH Options
# ===================
set :ssh_options, {
  keys: %w(~/.ssh/id_rsa),
  forward_agent: true,
  auth_methods: %w(publickey)
}
