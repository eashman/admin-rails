Rails.application.routes.draw do
  get 'viewer/index'

  scope '/users' do
    get 'new_user', to: 'users#new_user', as: 'new_user'
    post 'create_user', to: 'users#create_user', as: 'create_user'
  end


  root to: 'visitors#index'
end
