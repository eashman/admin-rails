Rails.application.routes.draw do
  get 'sync/index'

  get 'viewer/index'
  get 'viewer/files'

  get 'stream' => 'sync#index_stream'
  get 'watch' => 'sync#watch'
  #root to: 'users#watch'

  scope '/users' do
    get 'new_user', to: 'users#new_user', as: 'new_user'
    post 'create_user', to: 'users#create_user', as: 'create_user'
    get 'get_token', to: 'users#get_token', as: 'get_token'
    post 'get_user_token', to: 'users#get_user_token', as: 'get_user_token'
    post 'submit_assessment', to: 'users#submit_assessment', as: 'submit_assessment'

  end


  root to: 'visitors#index'
end
