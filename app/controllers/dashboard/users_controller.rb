class Dashboard::UsersController < ApplicationController
  before_action :authenticate_user!

  def update
    if current_user.update(user_params)
      redirect_to edit_dashboard_profile_path(current_user),
                  notice: "Ваши личные данные изменены"
    else
      flash.now[:alert] = "Возникли ошибки"
      render "dashboard/profiles/edit"
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :name, :avatar)
  end
end
