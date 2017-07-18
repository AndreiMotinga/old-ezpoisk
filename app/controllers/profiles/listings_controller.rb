class Profiles::ListingsController < ApplicationController
  layout "answers"

  def index
    @user = User.find(params[:profile_id])
    @listings = @user.listings.includes(:state, :city).page(params[:page])
    respond_to do |format|
      format.html
      format.js do
        render partial: "shared/index", locals: { records: @listings }
      end
    end
  end
end
