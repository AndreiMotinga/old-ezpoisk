# frozen_string_literal: true

module DashboardRoutes
  def self.extended(router)
    router.instance_exec do
      resources :partners, except: :show do
        get :duplicate, on: :member
      end
    end
  end
end
