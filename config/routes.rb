require "sidekiq/web"
require "sidekiq/cron/web"

Rails.application.routes.draw do
  # TODO: figure out why it's here
  default_url_options host: ENV.fetch("APPLICATION_HOST")

  namespace :listings do
    resources :categories, only: [:index]
    resources :subcategories, only: [:index]
  end

  resources :listings do
    collection do
      get(":kind(/:state(/:city))",
          kind: /real-estate|jobs|services|sales/,
          to: "listings#search",
          as: "search")
    end
  end

  resources :answers do
    collection do
      get "tag/:tag", to: "answers#tag", as: :tag
    end
  end
  resources :questions, only: [:new, :create, :show] do
    collection do
      get "unanswered", to: "questions#unanswered"
      get "unanswered/:tag", to: "questions#unanswered_tag", as: :unanswered_tag
    end
  end

  resources :posts

  resources :profiles, only: :show do
    member do
      get :questions
      get :posts
      get :listings
    end
  end

  resources :search_suggestions, only: [:index]
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  get "sitemaps/sitemap.:format.:compression", to: "sitemap#show"
  get "sitemaps/sitemap:id.:format.:compression", to: "sitemap#show_id"
  resources :cities, only: :index
  resources :summernote, only: [:create]
  resources :users, only: [:edit, :update]
  resources :pictures, only: [:index, :create, :update, :destroy]

  authenticate :user, ->(u) { u.admin? } do
    mount Sidekiq::Web => "/sidekiq"
    mount RailsAdmin::Engine => "/teacup", as: "rails_admin"
  end

  root to: "home#index"
end
