class MessagesController < ApplicationController
  def new
  end

  def create
    message = Message.new(message_params)
    message.user = current_user
    if message.save
      redirect_to root_path, notice: "Спасибо за ваш отзыв"
    else
      render :new, alert: "Отзыв не отпрвлен"
    end
  end

  private

  def message_params
    params.require(:message).permit(:body)
  end
end
