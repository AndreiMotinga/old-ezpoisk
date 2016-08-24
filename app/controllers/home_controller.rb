class HomeController < ApplicationController
  def index
    # todo only select name and avatar
    @posts = Post.includes(:user)
                 .home
                 .visible
                 .desc
                 .page(params[:page]).per(10)

    respond_to do |format|
      format.html
      format.js { render partial: "shared/index",
                         locals: { records: @posts } }
    end
  end

  def about
  end

  def contacts
  end
end
