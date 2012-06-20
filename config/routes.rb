LsTrivia::Application.routes.draw do
  resources :games
  resource :dashboard

  match "/current_game" => "games#current_game"

  root :to => 'pages#home'
end
