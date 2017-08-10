module AbsoleteRoutes
  def self.extended(router)
    router.instance_exec do
      get "/listings", to: redirect(URI.encode("/объявления"))
      get "/listings/jobs", to: redirect(URI.encode("/объявления/работа"))
    end
  end
end
