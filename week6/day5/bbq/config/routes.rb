Rails.application.routes.draw do
  devise_for :users
  root 'barbecues#index'

  resources :barbecues, only: [ :index, :show, :new, :create ]

  get 'api/barbecues/:id' => 'api_bbq#json_bbq'
  post 'api/barbecues/:id/join' => 'api_bbq#user_join'
  post 'api/barbecues/:id/items' => 'api_bbq#item_create', as: 'items'
end
