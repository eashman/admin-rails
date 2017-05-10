Rails.application.routes.draw do
  get 'viewer/index'

  scope '/users' do
    get 'new_user', to: 'users#new_user', as: 'new_user'
    post 'create_user', to: 'users#create_user', as: 'create_user'
    get 'get_token', to: 'users#get_token', as: 'get_token'
    post 'get_user_token', to: 'users#get_user_token', as: 'get_user_token'
  end


  root to: 'visitors#index'
end
