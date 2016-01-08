require 'sidekiq/web'

Rails.application.routes.draw do
  authenticate :user, ->(u) { u.admin? } do
    mount Sidekiq::Web => "/sidekiq"
    mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  end
  devise_for :users
  get "update_cities", to: "cities#update_cities"
  get "update_subcategory", to: "subcategories#update_subcategory"
  resources :news, only: [:index, :show]
  resources :comments, only: [:create]
  resources :feedbacks, only: [:new, :create]

  resource :dashboard, only: [:show]
  namespace :dashboard do
    resources :summernote, only: [:create]
    resources :pictures, only: [:index, :create, :update, :destroy]
    resources :re_agencies, except: :show
    resources :re_privates, except: :show
    resources :re_commercials, except: :show

    resources :job_agencies, except: :show
    resources :jobs, except: :show

    resources :sales, except: :show

    resources :services, except: :show
  end

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
