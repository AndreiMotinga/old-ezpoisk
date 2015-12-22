Rails.application.routes.draw do
  devise_for :users
  get "update_cities/:id", to: "cities#update_cities"
  resources :news

  namespace :real_estate do
    resources :re_agencies, only: [:index, :show]
    resources :re_privates, only: [:index, :show]
  end

  resource :dashboard, only: [:show]

  namespace :dashboard do
    resources :re_agencies
    resources :re_privates
  end

  root to: "home#index"
end
