# Server Options
# ===================
server 'demo-util.k2practice.com', user: 'deploy', roles: %w(app db web)
set :deploy_to, '/home/deploy/demo-util'

# Environment Options
# ===================
set :branch, 'demo'
set :stages, 'demo'
set :rails_env, 'demo'

# Build Options
# ===================
set :bundle_without, (fetch(:bundle_without, []) - %w(demo)).join(' ')

# Custom SSH Options
# ===================
set :ssh_options, {
    keys: %w(~/.ssh/id_rsa),
    forward_agent: true,
    auth_methods: %w(publickey)
}
