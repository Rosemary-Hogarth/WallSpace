Rails.application.routes.draw do
  devise_for :users

  get "up" => "rails/health#show", as: :rails_health_check

  root to: "pages#home"
  resources :artworks, only: [:index, :new, :create, :show, :edit, :update, :destroy]
  # Defines the root path route ("/")
get '/test', to: 'pages#test'
end
