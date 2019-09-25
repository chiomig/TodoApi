Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  scope module: 'api' do
    namespace :v1 do
      resources :tasks
      resources :users
      post 'user_token' => 'user_token#create'
    end
  end
end
