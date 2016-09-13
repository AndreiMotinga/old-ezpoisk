require "sidekiq/web"
require "sidekiq/cron/web"

Rails.application.routes.draw do
  default_url_options host: "https://www.ezpoisk.com"
  resources :stripe_subscriptions, only: [:create, :update, :destroy]
  resources :favorites, only: [:create]
  post "favorites/touch", to: "favorites#touch"

  resources :comments, only: [:create]
  resources :points, only: [:create]
  resources :subscriptions, only: [:create, :destroy]

  resources :users, only: [:show]
  resources :questions, except: [:destroy] do
    collection do
      get "tag/:tag", to: "questions#tag"
    end
    resources :answers, only: [:new, :edit]
  end
  resources :answers do
    collection do
      get "tag/:tag", to: "answers#tag"
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
  get "update_cities", to: "cities#update_cities"
  get "update_subcategory", to: "subcategories#update_subcategory"
  get '/tos', to: 'tos#tos'

  resource :dashboard, only: [:show]
  namespace :dashboard do
    resources :users, only: [:edit, :update]
    resources :re_privates, only: [:new, :create, :edit, :update, :destroy]
    resources :posts, only: [:new, :create, :edit, :update, :destroy] do
      authenticate :user, ->(u) { u.editor? } do
        collection do
          get "all"
          get "import"
          delete "destroy_all"
        end
      end
    end
    resources :jobs, only: [:new, :create, :edit, :update, :destroy]
    resources :sales, only: [:new, :create, :edit, :update, :destroy]
    resources :services, only: [:new, :create, :edit, :update, :destroy]

    resources :summernote, only: [:create]
    resources :pictures, only: [:index, :create, :update, :destroy]

    resources :favorites, only: [:index]

    resources :partners, except: [:show] do
      member do
        post "increment", to: "partners#increment"
        get "redirect", to: "partners#redirect"
      end
      resources :charges, only: [:new] do
        collection do
          post "week", action: "week", as: "week"
          post "biweek", action: "biweek", as: "biweek"
          post "quadroweek", action: "quadroweek", as: "quadroweek"
        end
      end
    end
  end

  resources :posts, only: [:index, :show] do
    get "tag/:tag", to: "posts#tag", as: "post_tag", on: :collection
  end
  resources :sales, only: [:index, :show]
  resources :services, only: [:index, :show]
  resources :re_privates, only: [:index, :show]
  resources :jobs, only: [:index, :show]

  authenticate :user, ->(u) { u.admin? } do
    get "feeds", to: "feeds#index"
    mount Sidekiq::Web => "/sidekiq_monstro"
    mount RailsAdmin::Engine => "/teacup", as: "rails_admin"
  end

  get "about", to: "home#about"
  get "contacts", to: "home#contacts"
  get "clean", to: "home#clean"
  root to: "home#index"
end
