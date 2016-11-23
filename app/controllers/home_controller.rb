class HomeController < ApplicationController
  def index
    @entries = Entry.includes(enterable: :user).news.desc.page(params[:page])
    respond_to do |format|
      format.html
      format.js { render partial: "shared/index",
                         locals: { records: @entries } }
    end
  end
end
