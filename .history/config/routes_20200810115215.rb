Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
  }
  devise_scope :user do
    get 'destinations', to: 'users/registrations#new_destination'
    post 'destinations', to: 'users/registrations#create_destination'
  end
  # get 'items/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'items#index'

  

  resources :categories
  
  resources :items
  resources :destinations

  get '/users/:id', to: 'users#show', as: 'user'
  # 馬場追記_名前付きルーティング
end
