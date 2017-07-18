require "sidekiq/web"
require "sidekiq/cron/web"

Rails.application.routes.draw do
  # TODO: figure out why it's here
  default_url_options host: ENV.fetch("APPLICATION_HOST")

  # TODO: remove with pg_search
  resources :searches, only: [:index]
  resources :comments, only: [:create]

  resources :posts
  resources :questions, only: [:new, :create, :show] do
    collection do
      get "unanswered", to: "questions#unanswered"
      get "unanswered/:tag", to: "questions#unanswered_tag", as: :unanswered_tag
    end
  end
  resources :answers do
    collection do
      get "tag/:tag", to: "answers#tag", as: :tag
    end
    member do
      put "upvote", to: "answers#upvote"
      put "downvote", to: "answers#downvote"
      put "unvote", to: "answers#unvote"
    end
  end

  resources :search_suggestions, only: [:index]
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  get "sitemaps/sitemap.:format.:compression", to: "sitemap#show"
  get "sitemaps/sitemap:id.:format.:compression", to: "sitemap#show_id"
  resources :cities, only: :index
  get "/tos", to: "tos#tos"

  namespace :dashboard do
    resources :listings, except: :show
    resources :pictures, only: [:index, :create, :update, :destroy]
    resources :summernote, only: [:create]
    resources :users, only: [:edit, :update]
    resources :reviews, except: :show
    resources :answers, only: [:index]
  end

  authenticate :user, ->(u) { u.editor? } do
    resources :editors, only: [:show, :update]
  end

  namespace :listings do
    resources :categories, only: [:index]
    resources :subcategories, only: [:index]
  end

  resources :listings, only: [:index, :show] do
    collection do
      get(":kind(/:state(/:city))",
          kind: /real-estate|jobs|services|sales/,
          to: "listings#search",
          as: "search")
    end
  end

  resources :profiles, only: :show do
    scope module: :profiles do
      resources :questions, only: [:index]
      resources :posts, only: [:index]
    end
  end


  authenticate :user, ->(u) { u.admin? } do
    mount Sidekiq::Web => "/sidekiq"
    mount RailsAdmin::Engine => "/teacup", as: "rails_admin"
  end

  resources :users, only: [:show]
  resources :posts, only: :show
  root to: "home#index"
end
