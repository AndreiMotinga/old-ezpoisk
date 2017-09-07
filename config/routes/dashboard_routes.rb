# frozen_string_literal: true

module DashboardRoutes
  def self.extended(router)
    router.instance_exec do
      authenticate :user, ->(u) { u.admin? } do
        namespace :dash do
          resources :imports, only: :index
        end

        resources :partners, except: :show do
          get :duplicate, on: :member
        end
      end
    end
  end
end
