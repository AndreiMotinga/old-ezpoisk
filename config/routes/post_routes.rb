# frozen_string_literal: true

module PostRoutes
  def self.extended(router)
    router.instance_exec do
      resources :posts do
        collection do
          get "tag/:tag", to: "posts#tag", as: :tag
        end

        member do
          put "upvote", to: "posts#upvote"
          put "downvote", to: "posts#downvote"
          put "unvote", to: "posts#unvote"
        end
      end
    end
  end
end
