module Commentable
  extend ActiveSupport::Concern

  module ClassMethods
  end

  included do
    has_many :comments, as: :commentable, dependent: :destroy

    def new_comment
      comments.build
    end
  end
end
