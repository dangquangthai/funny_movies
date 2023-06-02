Rails.application.routes.draw do
  devise_for :users

  devise_scope :user do
    post   '/custom/users/sign_in', to: 'users/sessions#create', as: :custom_sign_in
    delete '/custom/users/sign_out', to: 'users/sessions#destroy', as: :custom_sign_out
  end

  # Defines the root path route ("/")
  root "videos#index"

  resources :videos, only: [:index, :new, :create]

  namespace :engagements do
    get 'user_logged_state', to: 'user_logged_state#index', as: :user_logged_state
  end
end
