require "sidekiq/web"
require "sidekiq/cron/web"

Rails.application.routes.draw do
  # TODO: figure out why it's here
  default_url_options host: ENV.fetch("APPLICATION_HOST")
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }

  # LISTINGS
  namespace :listings do
    resources :categories, only: [:index]
    resources :subcategories, only: [:index]
  end
  resources :listings
  resources :cities, only: :index
  resources :pictures, only: [:index, :create, :update, :destroy]

  # ANSWERS
  resources :summernote, only: [:create]
  resources :search_suggestions, only: [:index]
  resources :answers do
    collection do
      get "tag/:tag", to: "answers#tag", as: :tag
    end
  end
  resources :questions, only: [:index, :new, :create, :show] do
    get "tag/:tag", to: "questions#tag", as: :tag, on: :collection
  end

  # POSTS
  resources :posts

  # PROFILES
  resources :profiles, only: :show do
    member do
      get :questions
      get :posts
      get :listings
    end
  end
  resources :users, only: [:edit, :update]

  # Utils
  get "sitemaps/sitemap.:format.:compression", to: "sitemap#show"
  get "sitemaps/sitemap:id.:format.:compression", to: "sitemap#show_id"

  authenticate :user, ->(u) { u.admin? } do
    mount Sidekiq::Web => "/sidekiq"
    mount RailsAdmin::Engine => "/teacup", as: "rails_admin"
  end

  root to: "home#index"
end
