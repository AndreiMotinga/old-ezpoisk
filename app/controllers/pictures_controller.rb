# frozen_string_literal: true

class PicturesController < ApplicationController
  def index
    @pictures = klass.find(params["id"]).pictures
  end

  def create
    @picture = user.images.build(picture_params)
    if @picture.save
      render json: { message: "success", fileID: @picture.id }
    else
      render json: { error: @picture.errors.full_messages.join(",") },
             status: 400
    end
  end

  def update
    @picture = Picture.find(params[:id])
    @picture.imageable.unset_logo
    @picture.update_attribute(:logo, true)
  end

  def destroy
    @id = params[:id]
    pic = Picture.find(@id)
    unless current_user.try(:can_edit?, pic) || pic.imageable.token == params[:token]
      redirect_to root_path
    end
    pic.destroy
  end

  private

  def user
    current_user || User.find(1)
  end

  def picture_params
    params.require(:picture).permit(:image, :imageable_id, :imageable_type)
  end

  def klass
    [User, Listing].find { |klass| klass.name == params[:type].classify }
  end
end
