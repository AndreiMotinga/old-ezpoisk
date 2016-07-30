class Dashboard::FavoritesController < ApplicationController
  before_action :authenticate_user!

  def index
    @favorites = current_user.favorites
      .includes(favorable: [:state, :city])
      .saved.page(params[:page])
  end
end
