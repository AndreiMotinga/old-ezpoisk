class FavoritesController < ApplicationController
  def create
    favorite = current_user.find_favorite(favorite_params)
    if favorite
      favorite.destroy
      render json: { status: 204 }
    else
      current_user.favorites.create(favorite_params)
      render json: { status: 201 }
    end
  end

  def touch
    @rec = model.find(rec_params[:id])
    if current_user.try(:can_edit?, @rec)
      @rec.touch(:created_at)
      @rec.entry.touch
      render :touch
    else
      render json: { status: 403 }
    end
  end

  private

  def rec_params
    params.require(:record).permit(:id, :type)
  end

  def favorite_params
    params.require(:favorite).permit(
      :favorable_id, :favorable_type, :saved, :hidden
    )
  end

  def model
    [RePrivate, Job, Sale, Service].find { |m| m.name == rec_params["type"] }
  end
end
