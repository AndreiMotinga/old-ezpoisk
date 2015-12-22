class Dashboard::RePrivatesController < ApplicationController
  layout "dashboard"
  before_action :authenticate_user!
  before_action :set_re_private, only: [:show, :edit, :update, :destroy]

  def index
    @re_privates = current_user.re_privates
  end

  def new
    @re_private = RePrivate.new
  end

  def show
  end

  def edit
  end

  def create
    @re_private = current_user.re_privates.build(re_private_params)

    if @re_private.save
      redirect_to dashboard_re_private_path(@re_private),
                  notice: "Re private was successfully created."
    else
      render :new
    end
  end

  def update
    if @re_private.update(re_private_params)
      redirect_to dashboard_re_private_path(@re_private),
                  notice: "Re private was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @re_private.destroy
    redirect_to dashboard_re_privates_path,
                notice: "Re private was successfully destroyed."
  end

  private

    def set_re_private
      @re_private = RePrivate.find(params[:id])
    end

  def re_private_params
    params.require(:re_private).permit(:street,
                                 :post_type,
                                 :duration,
                                 :apt,
                                 :phone,
                                 :price,
                                 :baths,
                                 :space,
                                 :rooms,
                                 :active,
                                 :fee,
                                 :description,
                                 :state_id,
                                 :city_id)
  end
end
