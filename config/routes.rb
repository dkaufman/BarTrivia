LsTrivia::Application.routes.draw do
  resources :games do
    member do
      get 'start'
      get 'finish'
    end
    resources :questions
  end
  resource :dashboard

  match "/current_game" => "games#current_game"

  root :to => 'pages#home'
end
