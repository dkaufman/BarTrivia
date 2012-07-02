LsTrivia::Application.routes.draw do
  namespace :api do
    resources :pending_games
    resource :game
    resource :team do
      get 'all'
    end
    resource :question do
      collection do
        get 'last'
        get 'current'
        post 'times_up'
        get 'count'
      end
      resources :responses do
        collection do
          get 'number_correct'
          post 'auto_grade'
        end
        member do
          post 'correct'
        end
      end
    end
  end


  resource :game do
    member do
      get 'start'
      get 'finish'
    end
    # resource :teams
    resources :questions, :only => [:index, :show]
  end

  match "current_game" => "games#current_game", as: :current_game
  match "next_question" => "questions#next", as: :next_question

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
