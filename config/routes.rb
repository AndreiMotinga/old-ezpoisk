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
  resources :subcategories, only: :index
  get '/tos', to: 'tos#tos'

  namespace :dashboard do
    resources :favorites, only: [:index]
    resources :pictures, only: [:index, :create, :update, :destroy]
    resources :summernote, only: [:create]
    resources :users, only: [:edit, :update]
    resources :re_privates, except: :show
    resources :jobs, except: :show
    resources :sales, except: :show
    resources :services, except: :show
    resources :reviews, except: :show
    resources :answers, only: [:index]
    resources :posts, except: :show
    authenticate :user, ->(u) { u.editor? } do
      resources :editors, only: [:show, :update]
      resources :posts, except: :show do
        collection do
          get "all"
          get "import"
          delete "destroy_all"
        end
      end
    end
    resources :partners do
      post "increment", to: "partners#increment", on: :collection
    end
  end

  resources :posts, only: [:index, :show] do
    get "tag/:tag", to: "posts#tag", as: "tag", on: :collection
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
    resources :imports, only: :index do
      collection do
        get "vk", to: "imports#vk"
        get "fb", to: "imports#fb"
      end
    end
    mount Sidekiq::Web => "/sidekiq_monstro"
    mount RailsAdmin::Engine => "/teacup", as: "rails_admin"
  end

  resources :users, only: [:show]
  get "clean", to: "home#clean"
  root to: "home#index"
end
