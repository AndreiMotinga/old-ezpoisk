class Dashboard::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ser_user, only: [:edit, :update]

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to edit_dashboard_user_path(@user),
                  notice: "Ваши личные данные изменены"
    else
      flash.now[:alert] = "Возникли ошибки"
      render :edit
    end
  end

  private

  def ser_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name,
                                 :phone,
                                 :email,
                                 :site,
                                 :slug,
                                 :state_id,
                                 :city_id,
                                 :avatar)
  end
end
