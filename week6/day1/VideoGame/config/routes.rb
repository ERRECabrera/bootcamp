Rails.application.routes.draw do
  get '/' => 'tournaments#index'

  get '/api/tournaments' => 'tournaments#jsontournament'
  get '/api/players' => 'players#jsonplayers'

  post '/api/tournaments' => 'tournaments#create'
  post '/api/players' => 'players#add_to_tournament'

  delete '/api/tournaments' => 'tournaments#destroy'
end
