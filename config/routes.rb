LsTrivia::Application.routes.draw do
  namespace :api do
    resource :game
    resource :team
  end


  resource :game do
    member do
      get 'start'
      get 'finish'
    end
    resource :teams
    resources :questions, :only => [:index, :show]
  end

  match "/current_game" => "games#current_game"

  resources :pending_games do
    member do
      get 'start'
    end
    resources :questions
  end

  resources :past_games
  resource :dashboard

  root :to => 'pages#home'
end
