class FeedbacksController < ApplicationController

  def create
    @feedback = Feedback.new(feedback_params)

    if @feedback.save
      SlackNotifierJob.perform_async(@feedback.id, "Feedback")
      redirect_to root_path, notice: 'Спасибо за сообщение'
    end
  end

  private

    def feedback_params
      params.require(:feedback).permit(:name, :email, :phone, :message)
    end
end
