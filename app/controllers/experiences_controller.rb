class ExperiencesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_experience, only: [:update, :destroy]

  def create
    @experience = current_user.experiences.build(experience_params)
    if @experience.save
      redirect_to edit_user_path(current_user, act: @experience.kind),
                  notice: I18n.t(:user_updated)
    else
      flash.now[:alert] = I18n.t(:post_not_saved)
      render :new
    end
  end

  def update
    if @experience.update(experience_params)
      redirect_to edit_user_path(current_user, act: @experience.kind),
                  notice: I18n.t(:user_updated)
    else
      flash.now[:alert] = I18n.t(:post_not_saved)
      render "users/edit"
    end
  end

  def destroy
    kind = @experience.kind
    @experience.destroy
    redirect_to edit_user_path(current_user, act: kind),
                notice: I18n.t(:user_updated)
  end

  private

  def experience_params
    params
      .require(:experience)
      .permit(:kind, :name, :title, :country, :city, :start_year, :end_year)
  end

  def set_experience
    @experience = current_user.experiences.find(params[:id])
  end
end
