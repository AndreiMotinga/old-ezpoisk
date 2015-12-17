Rails.application.routes.draw do
  devise_for :users
  resource :dashboard, only: [:show]
  root to: "home#index"
  resources :news, only: [:index]
end
