class HomeController < ApplicationController
  layout :resolve_layout

  def index
    @homepage = Homepage.new
  end

  def about
    @feedback = Feedback.new
  end

  private

  def resolve_layout
    case action_name
    when "about"
      "about"
    else
      "application"
    end
  end
end
