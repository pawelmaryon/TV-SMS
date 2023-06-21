Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "campaigns#index"
  resources :campaigns, only: [:index, :show] do
    resources :candidates, only: [:index, :show]
    resources :votes, only: [:index, :show]
  end
  post '/import_votes', to: 'campaigns#import_votes'
end
