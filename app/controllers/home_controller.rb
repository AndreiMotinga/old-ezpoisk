class HomeController < ApplicationController
  layout :resolve_layout

  def index
    @entries = Entry.includes(enterable: :user).news.desc.page(params[:page])
    respond_to do |format|
      format.html
      format.js { render partial: "shared/index",
                         locals: { records: @entries } }
    end
  end

  def clean
  end

  private

  def resolve_layout
    "plain" if action_name == "clean"
  end
end
