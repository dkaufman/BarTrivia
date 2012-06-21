LsTrivia::Application.routes.draw do
  resource :game do
    member do
      get 'start'
      get 'finish'
    end
    resources :questions, :only => [:index, :show]
  end
  resources :pending_games do
    member do
      get 'start'
    end
    resources :questions
  end
  resources :past_games
  resource :dashboard

  match "/current_game" => "games#current_game"

  root :to => 'pages#home'
end
