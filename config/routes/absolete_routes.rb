# frozen_string_literal: true

module AbsoleteRoutes
  def self.extended(router)
    router.instance_exec do
      # get "/listings", to: redirect(URI.encode("/объявления"))
      # get "/listings/jobs", to: redirect(URI.encode("/объявления/работа"))
      # get "/listings/services", to: redirect(URI.encode("/объявления/услуги"))
      # get "/listings/services/florida", to: redirect(URI.encode("/объявления?kind=услуги&state=florida"))
      # get "/listings/:id", to: redirect(URI.encode("/объявления/%{id}"))
      # get "/listings/jobs/massachusetts/boston", to: redirect(URI.encode("/объявления?kind=работа&state=massachusetts&city=boston"))
      #
      # get "/jobs", to: redirect(URI.encode("/объявления/работа"))
      # get "/jobs/:id", to: redirect(URI.encode("/объявления/%{id}"))
      # get "/jobs/tag/:tag", to: redirect(URI.encode("/объявления/работа"))
      # get "/re_privates", to: redirect(URI.encode("/объявления/недвижимость"))
      # get "/re_privates/:id", to: redirect(URI.encode("/объявления/%{id}"))
      # get "/real-estate", to: redirect(URI.encode("/объявления/недвижимость"))
      # get "/real-estate/:id", to: redirect(URI.encode("/объявления/%{id}"))
      # get "/sales", to: redirect(URI.encode("/объявления/продажи"))
      # get "/sales/:id", to: redirect(URI.encode("/объявления/%{id}"))
      # get "/services", to: redirect(URI.encode("/объявления/услуги"))
      # get "/services/:id", to: redirect(URI.encode("/объявления/%{id}"))
      # get "/job_agencies", to: redirect(URI.encode("/объявления"))
      # get "/job_agencies/:id", to: redirect(URI.encode("/объявления/%{id}"))
      # get "/eznews", to: redirect(URI.encode("/posts/"))
      # get "/eznews/:id", to: redirect(URI.encode("/posts/%{id}"))
      # get "/ezanswer", to: redirect("/answers")
      # get "/ezanswer/:id", to: redirect("/answers/%{id}")
      #
      get "/объявления/услуги/другое", to: redirect(URI.encode("/объявления/услуги/другое-разное"))
      get "/объявления/услуги/другое/:id", to: redirect(URI.encode("/объявления/услуги/другое-разное/%{id}"))
      get "/объявления/услуги/другое/:id/:id1", to: redirect(URI.encode("/объявления/услуги/другое-разное/%{id}/%{id1}"))
      get "/объявления/услуги/другое/:id/:id1/:id2", to: redirect(URI.encode("/объявления/услуги/другое-разное/%{id}/%{id1}/%{id2}"))
      get "/объявления/услуги/другое/:id/:id1/:id2/:id3", to: redirect(URI.encode("/объявления/услуги/другое-разное/%{id}/%{id1}/%{id2}/%{id3}"))
    end
  end
end
