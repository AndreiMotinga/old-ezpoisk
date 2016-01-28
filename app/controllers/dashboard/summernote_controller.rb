class Dashboard::SummernoteController < ApplicationController
  def create
    @picture = Picture.new(picture_params)

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
    params.require(:picture).permit(:imageable_id, :imageable_type, :image)
  end
end
