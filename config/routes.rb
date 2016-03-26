require 'sidekiq/web'

Rails.application.routes.draw do
  post "/favorites/create_favorite", to: "favorites#create_favorite"
  post "/favorites/create_hidden", to: "favorites#create_hidden"
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
  get "sitemaps/sitemap(:id).:format.:compression" => "sitemap#show"
  get "update_cities", to: "cities#update_cities"
  get "update_subcategory", to: "subcategories#update_subcategory"
  get '/tos', to: 'tos#tos'
  resources :feedbacks, only: [:create]

  resource :dashboard, only: [:show]
  namespace :dashboard do
    resources :users, only: [:edit, :update]
    resources :re_agencies, only: [:new, :create, :edit, :update, :destroy]
    resources :re_finances, only: [:new, :create, :edit, :update, :destroy]
    resources :re_privates, only: [:new, :create, :edit, :update, :destroy]
    resources :re_commercials, only: [:new, :create, :edit, :update, :destroy]

    resources :job_agencies, only: [:new, :create, :edit, :update, :destroy]
    resources :jobs, only: [:new, :create, :edit, :update, :destroy]

    resources :sales, only: [:new, :create, :edit, :update, :destroy]
    resources :services, only: [:new, :create, :edit, :update, :destroy]

    resources :summernote, only: [:create]
    resources :pictures, only: [:index, :create, :update, :destroy]

    resources :favorites, only: [:index]
    resources :partners
  end

  resources :news, only: [:index, :show], path: :eznews
  resources :horoscopes, only: [:index], path: :ezscope
  resources :sales, only: [:index, :show], path: :ezsale
  resources :services, only: [:index, :show], path: :ezservice

  namespace :ezrealty do
    resources :re_agencies, only: [:index, :show], path: :agencies
    resources :re_finances, only: [:index, :show], path: :finance
    resources :re_privates, only: [:index, :show], path: :private
    resources :re_commercials, only: [:index, :show], path: :commercial
  end

  namespace :ezjob do
    resources :job_agencies, only: [:index, :show], path: :agencies
    resources :jobs, only: [:index, :show]
  end

  authenticate :user, ->(u) { u.admin? } do
    resources :companies
    mount Sidekiq::Web => "/sidekiq_monstro"
    resources :news, only: [:edit, :update, :destroy], path: :eznews
    get "all_news", to: "news#all"
    resource :admin, only: [:show], constraints: { subdomain: 'www' }
    constraints subdomain: "godzilla" do
      constraints BlacklistConstraint.new do
        mount RailsAdmin::Engine => "/teacup", as: "rails_admin"
      end
    end
  end

  get "about", to: "home#about"
  get "htmltagstrippingtool", to: "htmltagstrippingtool#index"

  root to: "home#index"
end
