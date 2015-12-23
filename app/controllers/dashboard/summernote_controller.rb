class Dashboard::SummernoteController < ApplicationController
  def create
    @picture = Picture.new(picture_params)
    @picture.imageable_id = params[:id]
    @picture.imageable_type = params[:type]

    if @picture.save
      render json: { message: "success",
                     fileID: @picture.id,
                     url: @picture.image.url }
    else
      render json: { error: @picture.errors.full_messages.join(",") },
                     status: 400
    end
  end

  private

  def picture_params
    params.require(:picture).permit(:image, :imageable_id, :imageable_type)
  end
end
