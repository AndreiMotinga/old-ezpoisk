class ApplicationController < ActionController::API
  def index
    render json: { app: "ezpoisk" }, status: :success
  end
end
