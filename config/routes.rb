Rails.application.routes.draw do
  devise_for :users
  resource :dashboard, only: [:show]
  resources :news

  namespace :real_estate do
    resources :re_agencies, only: [:index, :show]
    resources :re_privates, only: [:index, :show]
  end

  namespace :dashboard do
    namespace :real_estate do
      resources :re_agencies, only: [:new]
    end
  end

  root to: "home#index"
end
