require 'sidekiq/web'

Rails.application.routes.draw do
  authenticate :user, ->(u) { u.admin? } do
    mount Sidekiq::Web => "/sidekiq"
  end
  devise_for :users
  get "update_cities/:id", to: "cities#update_cities"
  resources :news

  namespace :real_estate do
    resources :re_agencies, only: [:index, :show]
    resources :re_privates, only: [:index, :show]
    resources :re_commercials, only: [:index, :show]
  end

  resource :dashboard, only: [:show]

  namespace :dashboard do
    resources :summernote, only: [:create]
    resources :pictures, only: [:index, :create, :update, :destroy]
    resources :re_agencies
    resources :re_privates, except: :show
    resources :re_commercials
  end

  root to: "home#index"
end
