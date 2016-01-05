require 'sidekiq/web'

Rails.application.routes.draw do
  authenticate :user, ->(u) { u.admin? } do
    mount Sidekiq::Web => "/sidekiq"
    mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  end
  devise_for :users
  get "update_cities/:id", to: "cities#update_cities"
  resources :news, only: [:index, :show]
  resources :comments, only: [:create]
  resources :messages, only: [:new, :create]

  resource :dashboard, only: [:show]
  namespace :dashboard do
    resources :summernote, only: [:create]
    resources :pictures, only: [:index, :create, :update, :destroy]
    resources :re_agencies, except: :show
    resources :re_privates, except: :show
    resources :re_commercials, except: :show
  end

  namespace :real_estate do
    resources :re_agencies, only: [:index, :show]
    resources :re_privates, only: [:index, :show]
    resources :re_commercials, only: [:index, :show]
  end

  root to: "home#index"
end
