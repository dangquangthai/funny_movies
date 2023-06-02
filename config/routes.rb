Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "videos#index"

  resources :videos, only: [:index, :new, :create]

  namespace :engagements do
    get 'user_logged_state', to: 'user_logged_state#index', as: :user_logged_state
  end
end
