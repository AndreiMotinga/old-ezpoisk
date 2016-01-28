class AdminsController < ApplicationController
  def show
    SlackHackNotifierJob.perform_async(current_user.id)
  end
end
