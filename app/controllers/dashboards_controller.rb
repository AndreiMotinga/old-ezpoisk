class DashboardsController < ApplicationController
  layout "dashboard"
  before_action :authenticate_user!

  def show
  end
end
