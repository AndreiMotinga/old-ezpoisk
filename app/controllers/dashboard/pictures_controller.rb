class Dashboard::PicturesController < ApplicationController
  def index
    @pictures = params["type"].constantize.find(params["id"]).pictures
  end

  def create
    @picture = Picture.new(picture_params)

    if @picture.save
      render json: { message: "success",
                     fileID: @picture.id }
    else
      render json: { error: @picture.errors.full_messages.join(",") },
                     status: 400
    end
  end

  def update
    @picture = Picture.find(params[:id])
    unset_current_logo
    @picture.logo = true
    @picture.save
  end

  def destroy
    @id = params[:id]
    Picture.find(@id).destroy
  end

  private

  def picture_params
    params.require(:picture).permit(:image, :imageable_id, :imageable_type)
  end

  def unset_current_logo
    current_logo = @picture.imageable.logo
    return unless current_logo
    current_logo.logo = false
    current_logo.save
  end

end
