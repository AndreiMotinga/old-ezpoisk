class Dashboard::FavoritesController < ApplicationController
  before_action :authenticate_user!

  def index
    @records = current_user.favorites
                           .includes(favorable: [:state, :city])
                           .saved
                           .page(params[:page])
    respond_to do |format|
      format.html
      format.js do
        render partial: "shared/index", locals: { records: @records }
      end
    end
  end
end
