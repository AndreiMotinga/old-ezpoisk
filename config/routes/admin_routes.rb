# frozen_string_literal: true

module AdminRoutes
  def self.extended(router)
    router.instance_exec do

      authenticate :user, ->(u) { u.admin? } do
        mount Sidekiq::Web => "/sidekiq"
        mount RailsAdmin::Engine => "/teacup", as: "rails_admin"
        get "/articles", to: "articles#index"
      end

    end
  end
end
