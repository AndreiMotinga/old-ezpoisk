Rails.application.routes.draw do
  devise_for :users
  resource :dashboard, only: [:show]
  resources :news

  resource :real_estate, only: [:show]

  root to: "home#index"
end
