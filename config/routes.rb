require "sidekiq/web"

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

  resources :questions, except: [:destroy], path: :ezanswer do
    collection do
      get "unanswered"
      get "tag/:tag", to: "questions#tag"
    end
    member do
      put "subscribe", to: "questions#subscribe"
      put "unsubscribe", to: "questions#unsubscribe"
    end
    resources :answers, only: [:new, :edit]
  end
  resources :answers, only: [:create, :update, :destroy] do
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
    resources :re_commercials, only: [:new, :create, :edit, :update, :destroy]
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

  resources :sales, only: [:index, :show], path: :ezsale
  resources :services, only: [:index, :show], path: :ezservice
  resources :re_privates, only: [:index, :show]
  resources :re_commercials, only: [:index, :show]
  resources :jobs, only: [:index, :show]

  authenticate :user, ->(u) { u.admin? } do
    mount Sidekiq::Web => "/sidekiq_monstro"
    resources :posts, only: [:edit, :update] do
      get :all, on: :collection
      get :import, on: :collection
      delete :destroy_all, on: :collection
    end
    # doesn't work sines ip through cloudflare is different every time
    # constraints BlacklistConstraint.new do
    mount RailsAdmin::Engine => "/teacup", as: "rails_admin"
    # end
  end
  resources :posts, only: [:index, :show]

  get "htmltagstrippingtool", to: "htmltagstrippingtool#index"
  get "about", to: "home#about"
  root to: "home#index"
end
