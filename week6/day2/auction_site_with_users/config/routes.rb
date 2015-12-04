Rails.application.routes.draw do
  get "/" => "site#home"

  resources :users, only: [:show, :new, :index, :create, :destroy] do
    resources :products, only: [:index, :show, :new, :create, :destroy] do
      resources :bids, only: [:create]
    end
  end

  get '/login' => "sessions#new"
  post '/login' => "sessions#create"
  delete '/logout' => "sessions#destroy"

  post '/reviews' => "reviews#create"
  delete '/reviews' => "reviews#destroy"
end
