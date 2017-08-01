class HomeController < ApplicationController
  layout "answers"

  def index
    @actions = Action.includes(actionable: :user)
                     .order(updated_at: :desc)
                     .page(params[:page])
    @popular = Post.order(created_at: :desc).take(5)

    respond_to do |format|
      format.html
      format.js do
        render partial: "shared/index", locals: { records: @actions }
      end
    end
  end
end
