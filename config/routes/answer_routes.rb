# frozen_string_literal: true

module AnswerRoutes
  def self.extended(router)
    router.instance_exec do

      # ANSWERS
      resources :summernote, only: [:create]
      resources :search_suggestions, only: [:index]
      resources :answers do
        get "tag/:tag", to: "answers#tag", as: :tag, on: :collection

        member do
          put "upvote", to: "answers#upvote"
          put "downvote", to: "answers#downvote"
          put "unvote", to: "answers#unvote"
        end
      end

      resources :questions do
        get "tag/:tag", to: "questions#tag", as: :tag, on: :collection

        member do
          put "upvote", to: "questions#upvote"
          put "downvote", to: "questions#downvote"
          put "unvote", to: "questions#unvote"
        end
      end

    end
  end
end
