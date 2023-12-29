Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  root "static_pages#home"

  get "sign_in", to: "sessions#new"
  get "sign_up", to: "users#new"
  delete "sign_out", to: "sessions#destroy"

  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }
  resources :users, only: %i[show create]

  namespace :developments do
    resources :sessions, only: %i[create]
  end
end
