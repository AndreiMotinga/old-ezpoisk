require 'sidekiq/web'

Rails.application.routes.draw do
  devise_for :users
  authenticate :user, ->(u) { u.admin? } do
    mount Sidekiq::Web => "/sidekiq"
    mount RailsAdmin::Engine => "/admin", as: "rails_admin"
  end
  authenticate :user, ->(u) { u.author? } do
    resources :news, only: [:new, :create, :edit, :update]
    resources :companies
  end
  get "sitemaps/sitemap(:id).:format.:compression" => "sitemap#show"
  get "sitemap(:id).:format.:compression" => "sitemap#index"
  get "update_cities", to: "cities#update_cities"
  get "update_subcategory", to: "subcategories#update_subcategory"

  resource :dashboard, only: [:show]
  namespace :dashboard do
    resources :re_agencies, except: :show
    resources :re_privates, except: :show
    resources :re_commercials, except: :show

    resources :job_agencies, except: :show
    resources :jobs, except: :show

    resources :sales, except: :show
    resources :services, except: :show

    resources :summernote, only: [:create]
    resources :pictures, only: [:index, :create, :update, :destroy]
  end

  resources :news, only: [:index, :show]
  resources :comments, only: [:create]
  resources :feedbacks, only: [:new, :create]
  mount Forem::Engine, at: "/forums"
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

  root to: "home#index"
end
