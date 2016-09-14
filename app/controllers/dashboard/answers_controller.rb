class Dashboard::AnswersController < ApplicationController
  before_action :authenticate_user!

  def index
    @answers = current_user.answers.includes(:taggings).page(params[:page])
    respond_to do |format|
      format.html
      format.js do
        render partial: "shared/index", locals: { records: @answers }
      end
    end
  end
end
