class Dashboard::PicturesController < ApplicationController
  def index
    @pictures = klass.find(params["id"]).pictures
  end

  def create
    @picture = current_user.images.build(picture_params)
    if @picture.save
      render json: { message: "success", fileID: @picture.id }
    else
      render json: { error: @picture.errors.full_messages.join(",") },
             status: 400
    end
  end

  def update
    @picture = current_user.images.find(params[:id])
    @picture.imageable.unset_logo
    @picture.update_attribute(:logo, true)
  end

  def destroy
    @id = params[:id]
    current_user.images.find(@id).destroy
  end

  private

  def picture_params
    params.require(:picture).permit(:image, :imageable_id, :imageable_type)
  end

  def klass
    [User, Listing].find do |class_name|
      class_name.name == params["type"].classify
    end
  end
end
