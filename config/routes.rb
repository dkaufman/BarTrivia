LsTrivia::Application.routes.draw do
  resources :games
  resource :dashboard

  root :to => 'pages#home'
end
