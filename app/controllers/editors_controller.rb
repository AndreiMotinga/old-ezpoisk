class EditorsController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    @answers = @user.answers.unpaid.desc
    redirect_to root_path unless @user == current_user || current_user.admin?
  end

  def update
    @user = User.find(params[:id])
    @user.answers.unpaid.update_all(paid: true)
    redirect_to editor_path(@user)
  end
end