class HomeController < ApplicationController
  def index
    @actions = Action.includes(actionable: :user)
                     .order(created_at: :desc)
                     .page(params[:page])
    @posts = Post.last(5)

    respond_to do |format|
      format.html
      format.js do
        render partial: "shared/index", locals: { records: @actions }
      end
    end
  end
end
