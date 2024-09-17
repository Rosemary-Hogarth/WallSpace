Rails.application.routes.draw do
  devise_for :users
  get 'profiles/show'

  get "up" => "rails/health#show", as: :rails_health_check

  root to: "pages#home"
  resources :artworks, only: [:index, :new, :create, :show, :edit, :update, :destroy]

   get '/profile/:id', to: 'profiles#show', as: 'profile'
  get '/profile', to: 'profiles#show'
  # Defines the root path route ("/")
get '/test', to: 'pages#test'
end
