class HomeController < ApplicationController
  def index
    @answers = Answer.includes(:user).desc.page(params[:page])
    respond_to do |format|
      format.html
      format.js { render partial: "shared/index",
                         locals: { records: @answers } }
    end
  end

  def lets
    render text: "_IGA3is9CQZfD5km-DYIJ-t8ZPDifjDA2lcshi6Ffpg.b1PiULHHoNe11AhEMh8b1ItLr7bUVus_Xl3SSMee7O4"
  end
end
