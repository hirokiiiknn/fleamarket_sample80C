Rails.application.routes.draw do
  get 'purchase/index'
  get 'purchase/done'
  devise_for :users, controllers: {
    registrations: 'users/registrations',
  }
  devise_scope :user do
    get 'destinations', to: 'users/registrations#new_destination'
    post 'destinations', to: 'users/registrations#create_destination'
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  # get 'items/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'items#index'
  resources :categories
  
  resources :items do
    collection do
      get 'get_category_children', defaults: { fomat: 'json'}
      get 'get_category_grandchildren', defaults: { fomat: 'json'}
      get 'search'
      get 'post_done'
      get 'delete_done'
      get 'detail_search'
      get 'update_done'
    end
  end
  
  resources :destinations

  resources :cards, except: :index do
    collection do
      get 'registration_done'
      get 'delete_done'
    end
    member do
      get 'buy'
      post 'pay'
    end
  end

  
  get '/users/:id', to: 'users#show', as: 'user'
  # 馬場追記_名前付きルーティング
  # as で名前定義→user_pathでコントローラーで使用可能


end
