require 'sidekiq/web'

Rails.application.routes.draw do
  resources :search_suggestions
  resources :questions do
    collection do
      get "unanswered"
    end
  end
  resources :answers, only: [:create, :update, :destroy] do
    member do
      put "upvote", to: "answers#upvote"
      put "downvote", to: "answers#downvote"
      put "unvote", to: "answers#unvote"
    end
  end

  devise_for :users, :controllers => {:registrations => "registrations"}
  get "sitemaps/sitemap(:id).:format.:compression" => "sitemap#show"
  get "sitemap(:id).:format.:compression" => "sitemap#index"
  get "update_cities", to: "cities#update_cities"
  get "update_subcategory", to: "subcategories#update_subcategory"
  get '/tos', to: 'tos#tos'

  resource :dashboard, only: [:show]
  namespace :dashboard do
    resources :re_agencies, only: [:new, :create, :edit, :update, :destroy]
    resources :re_privates, only: [:new, :create, :edit, :update, :destroy]
    resources :re_commercials, only: [:new, :create, :edit, :update, :destroy]

    resources :job_agencies, only: [:new, :create, :edit, :update, :destroy]
    resources :jobs, only: [:new, :create, :edit, :update, :destroy]

    resources :sales, only: [:new, :create, :edit, :update, :destroy]
    resources :services, only: [:new, :create, :edit, :update, :destroy]

    resources :summernote, only: [:create]
    resources :pictures, only: [:index, :create, :update, :destroy]
  end

  resources :news, only: [:index, :show]
  resources :comments, only: [:create]
  resources :feedbacks, only: [:new, :create]
  resources :horoscopes, only: [:index]
  resources :sales, only: [:index, :show]
  resources :services, only: [:index, :show]
  namespace :real_estate do
    resources :re_agencies, only: [:index, :show]
    resources :re_privates, only: [:index, :show]
    resources :re_commercials, only: [:index, :show]
  end

  namespace :jobs do
    resources :job_agencies, only: [:index, :show]
    resources :jobs, only: [:index, :show]
  end

  authenticate :user, ->(u) { u.admin? } do
    resources :companies
    mount Sidekiq::Web => "/sidekiq_monstro"
    resources :news, only: [:edit, :update, :destroy]
    resource :admin, only: [:show], constraints: { subdomain: 'www' }
    constraints subdomain: "godzilla" do
      constraints BlacklistConstraint.new do
        mount RailsAdmin::Engine => "/teacup", as: "rails_admin"
      end
    end
  end
  root to: "home#index"
end
