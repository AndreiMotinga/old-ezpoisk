require "sidekiq/web"
require "sidekiq/cron/web"

Rails.application.routes.draw do
  default_url_options host: "https://www.ezpoisk.com"
  resources :stripe_subscriptions, only: [:create]
  resources :favorites, only: [:create]
  post "favorites/touch", to: "favorites#touch"

  resources :deactivations, only: [:create]
  resources :comments, only: [:create]
  resources :points, only: [:create]
  resources :subscriptions, only: [:create, :destroy]

  resources :questions, except: [:edit, :update, :destroy] do
    collection do
      get "tag/:tag", to: "questions#tag", as: :tag
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
  get "update_subcategory", to: "subcategories#update_subcategory"
  get '/tos', to: 'tos#tos'

  namespace :dashboard do
    resources :favorites, only: [:index]
    resources :pictures, only: [:index, :create, :update, :destroy]
    resources :summernote, only: [:create]
    resources :users, only: [:edit, :update]
    resources :re_privates
    resources :jobs
    resources :sales
    resources :services
    resources :reviews
    resources :answers, only: [:index]
    resources :posts
    authenticate :user, ->(u) { u.editor? } do
      resources :editors, only: [:show, :update]
      resources :posts do
        collection do
          get "all"
          get "import"
          delete "destroy_all"
        end
      end
    end
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
  resources :sales, only: [:index, :show] do
    collection do
      get ":state(/:city(/:category))", state: /\D*?/, to: "sales#search", as: "search"
    end
  end

  resources :services, only: [:index, :show] do
    collection do
      get ":state(/:city(/:category(/:subcategory)))",
          state: /\D*?/, to: "services#search", as: "search"
    end
  end
  resources :re_privates, only: [:index, :show], path: "real-estate" do
    collection do
      get ':state(/:city(/:category(/:post_type)))', state: /\D*?/, to: "re_privates#search", as: "search"
    end
  end
  resources :jobs, only: [:index, :show] do
    collection do
      get "tag/:tag", to: "jobs#tag", as: :tag
      get ":state(/:city(/:category))", state: /\D*?/, to: "jobs#search", as: "search"
    end
  end

  authenticate :user, ->(u) { u.admin? } do
    get "feeds", to: "feeds#index"
    get "importer", to: "feeds#importer"
    get "import_vk", to: "feeds#import_vk"
    get "import_fb", to: "feeds#import_fb"
    mount Sidekiq::Web => "/sidekiq_monstro"
    mount RailsAdmin::Engine => "/teacup", as: "rails_admin"
  end

  resources :users, only: [:show]
  get "about", to: "home#about"
  get "contacts", to: "home#contacts"
  get "clean", to: "home#clean"
  root to: "home#index"
end
