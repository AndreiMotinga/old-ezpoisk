class Profiles::QuestionsController < ApplicationController
  layout "answers"

  def index
    @user = User.find(params[:profile_id])
    @questions = @user.questions.page(params[:page])
    @tags = Question.tag_counts.sort_by(&:name)
    respond_to do |format|
      format.html
      format.js do
        render partial: "shared/index", locals: { records: @questions }
      end
    end
  end
end
