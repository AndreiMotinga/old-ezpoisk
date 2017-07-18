class Profiles::PostsController < ApplicationController
  layout "answers"

  def index
    @user = User.find(params[:profile_id])
    @posts = @user.posts.page(params[:page])
    respond_to do |format|
      format.html
      format.js do
        render partial: "shared/index", locals: { records: @posts }
      end
    end
  end
end
