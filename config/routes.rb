Rails.application.routes.draw do
  devise_for :users
  resource :dashboard, only: [:show]
  resources :news

  resource :real_estate, only: [:show]
  namespace :real_estate do
    resources :re_agencies, only: [:index, :show]
    resources :re_privates, only: [:index, :show]
  end

  root to: "home#index"
end
