class Dashboard::PicturesController < ApplicationController
  def index
    @pictures = klass.find(params["id"]).pictures
    @view = klass == Profile ? "profiles/picture" : "dashboard/pictures/picture"
  end

  def create
    @picture = current_user.pictures.build(picture_params)
    return unless @picture.imageable.user == current_user

    if @picture.save
      render json: { message: "success", fileID: @picture.id }
    else
      render json: { error: @picture.errors.full_messages.join(",") },
             status: 400
    end
  end

  def update
    @picture = current_user.pictures.find(params[:id])
    @picture.imageable.unset_logo
    @picture.update_attribute(:logo, true)
  end

  def destroy
    @id = params[:id]
    current_user.pictures.find(@id).destroy
  end

  private

  def picture_params
    params.require(:picture).permit(:image, :imageable_id, :imageable_type)
  end

  def klass
    [Profile, RePrivate, ReCommercial, Sale].find do |class_name|
      class_name.name == params["type"].classify
    end
  end
end
