# frozen_string_literal: true

require "sidekiq/web"
require "sidekiq/cron/web"

Rails.application.routes.draw do
  default_url_options host: ENV.fetch("APPLICATION_HOST")
  devise_for :users, skip: [:sessions, :registrations], controllers: {
    omniauth_callbacks: "users/omniauth_callbacks"
  }
  devise_scope :user do
    get 'sign_out', :to => 'devise/sessions#destroy', :as => :destroy_user_session
  end

  resources :comments, only: [:create]
  resources :searches, only: :index

  # LISTINGS
  namespace :listings do
    resources :subcategories, only: [:index]
  end

  extend AbsoleteRoutes
  extend AnswerRoutes
  extend PostRoutes
  extend DashboardRoutes
  extend UserRoutes
  extend AdminRoutes
  extend UtilRoutes

  resources :listings, path: "объявления" do
    get ":kind(/:category(/:subcategory(/:state(/:city))))",
      constraints: lambda { |req| RU_KINDS.keys.include? req.params[:kind] },
      to: "listings#search",
      as: "search",
      on: :collection
    post :touch, on: :member
  end
  resources :cities, only: :index
  resources :pictures, only: [:index, :create, :update, :destroy]

  get "/messages", to: "home#react", constraints: -> (request) do
    !request.xhr? && request.format.html?
  end

  namespace :my do
    resources :listings, only: :index
  end

  root to: "listings#index"
end
