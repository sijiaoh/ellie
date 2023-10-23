Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  root "static_pages#home"

  get "sign_in", to: "sessions#new"
  get "sign_up", to: "users#new"
  delete "sign_out", to: "sessions#destroy"

  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }
  resources :users, param: :hashid, only: %i[show create] do
    scope module: :users do
      resource :setting, only: %i[show edit update]
    end
  end
  resources :posts, param: :hashid

  namespace :developments do
    resources :sessions, only: %i[create]
  end
end
