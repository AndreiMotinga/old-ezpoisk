class FeedbacksController < ApplicationController
  def new
    @feedback = Feedback.new name: current_user.try(:name),
                             email: current_user.try(:email)
  end

  def create
    feedback = Feedback.new(message_params)
    feedback.user = current_user
    if feedback.save
      AdminMailerJob.perform_async(feedback.id, "Feedback")
      redirect_to root_path, notice: I18n.t(:thanks_for_feedback)
    else
      render :new, alert: I18n.t(:feedback_not_sent)
    end
  end

  private

  def message_params
    params.require(:feedback).permit(:body, :name, :email)
  end
end
