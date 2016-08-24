require "sidekiq/web"
require "sidekiq/cron/web"

Rails.application.routes.draw do
  default_url_options host: "https://www.ezpoisk.com"
  resources :stripe_subscriptions, only: [:create, :update, :destroy]
  resources :favorites, only: [:create]
  post "favorites/touch", to: "favorites#touch"

  resources :comments, only: [:create]

  get "profiles/:id", to: "profiles#show", as: :profile
  get "profiles/:id/contacts", to: "profiles#contacts", as: :profile_contacts
  get "profiles/:id/posts", to: "profiles#posts", as: :profile_posts
  get "profiles/:id/listings", to: "profiles#listings", as: :profile_listings
  get "profiles/:id/answers", to: "profiles#answers", as: :profile_answers
  get "profiles/:id/gallery", to: "profiles#gallery", as: :profile_gallery

  resources :points, only: [:create]
  resources :subscriptions, only: [:create, :destroy]

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
  resources :feedbacks, only: [:create]

  resource :dashboard, only: [:show]
  namespace :dashboard do
    resources :profiles, only: [:edit, :update]
    resources :users, only: [:edit, :update]
    resources :re_privates, only: [:new, :create, :edit, :update, :destroy]
    resources :posts, only: [:index, :new, :create, :edit, :update, :destroy]
    resources :jobs, only: [:new, :create, :edit, :update, :destroy]
    resources :sales, only: [:new, :create, :edit, :update, :destroy]
    resources :services, only: [:new, :create, :edit, :update, :destroy]

    resources :summernote, only: [:create]
    resources :pictures, only: [:index, :create, :update, :destroy]

    resources :favorites, only: [:index]

    resources :partners, except: [:edit, :update] do
      resources :charges, only: [:new] do
        collection do
          post "week", action: "week", as: "week"
          post "biweek", action: "biweek", as: "biweek"
          post "quadroweek", action: "quadroweek", as: "quadroweek"
        end
      end
    end
  end

  authenticate :user, ->(u) { u.editor? } do
    get 'posts/all', to: "posts#all"
    get 'posts/import', to: "posts#import"
    delete 'posts/destroy_all', to: "posts#destroy_all"
  end

  resources :posts, only: [:index, :show]
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
  root to: "home#index"
end
