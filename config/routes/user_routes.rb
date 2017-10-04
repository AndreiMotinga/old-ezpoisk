# frozen_string_literal: true

module UserRoutes
  def self.extended(router)
    router.instance_exec do
      resources :users, path: "profiles", only: [:show, :edit, :update] do
        member do
          get :questions
          get :posts
          get :listings

          put "upvote", to: "users#upvote"
          put "unvote", to: "users#unvote"
          put "contact", to: "users#contact"
        end
      end

      resources :experiences, only: [:create, :update, :destroy]
      resources :contacts, only: [:update]

      resources :impressions, only: [:show, :create]
    end
  end
end
