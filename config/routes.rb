require "sidekiq/web"
require "sidekiq/cron/web"

Rails.application.routes.draw do
  # TODO: figure out why it's here
  default_url_options host: ENV.fetch("APPLICATION_HOST")
  devise_for :users, skip: [:sessions, :registrations], controllers: {
    omniauth_callbacks: "users/omniauth_callbacks"
  }
  devise_scope :user do
     get 'sign_out', :to => 'devise/sessions#destroy', :as => :destroy_user_session
  end

  resources :comments, only: [:create]

  # LISTINGS
  namespace :listings do
    resources :categories, only: [:index]
    resources :subcategories, only: [:index]
  end

  resources :listings, path: "объявления" do
    get ":kind(/:category(/:subcategory(/:state(/:city))))",
      constraints: lambda { |req| %w(работа недвижимость услуги продажи).include? req.params[:kind] },
      to: "listings#search",
      as: "search",
      on: :collection
  end
  resources :cities, only: :index
  resources :pictures, only: [:index, :create, :update, :destroy]

  # ANSWERS
  resources :summernote, only: [:create]
  resources :search_suggestions, only: [:index]
  resources :answers do
    get "tag/:tag", to: "answers#tag", as: :tag, on: :collection

    member do
      put "upvote", to: "answers#upvote"
      put "downvote", to: "answers#downvote"
      put "unvote", to: "answers#unvote"
    end
  end

  resources :questions, only: [:index, :new, :create, :show] do
    get "tag/:tag", to: "questions#tag", as: :tag, on: :collection
  end

  # POSTS
  resources :posts do
    collection do
      get "tag/:tag", to: "posts#tag", as: :tag
    end
  end

  resources :users, path: "profiles", only: [:show, :edit, :update] do
    member do
      get :questions
      get :posts
      get :listings
    end
  end
  resources :experiences, only: [:create, :update, :destroy]

  # Utils
  get "sitemaps/sitemap.:format.:compression", to: "sitemap#show"
  get "sitemaps/sitemap:id.:format.:compression", to: "sitemap#show_id"

  authenticate :user, ->(u) { u.admin? } do
    mount Sidekiq::Web => "/sidekiq"
    mount RailsAdmin::Engine => "/teacup", as: "rails_admin"
  end

  root to: "home#index"
end
