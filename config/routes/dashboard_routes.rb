# frozen_string_literal: true

module DashboardRoutes
  def self.extended(router)
    router.instance_exec do

      resources :campaigns, except: :show do
        resources :partners, expect: :show do
          get :duplicate, on: :member
        end
      end
    end
  end
end
