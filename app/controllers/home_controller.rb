# frozen_string_literal: true

class HomeController < PagesController
  layout :set_layout
  after_action(only: :index) { create_show_impressions(@actions.map(&:actionable)) }

  def index
    @actions = Action.includes(actionable: :user)
                     .visible
                     .order(created_at: :desc)
                     .page(params[:page])
    @popular = Post.order(created_at: :desc).take(5)
    @top, @left, @right = Partner.side
    respond_to do |format|
      format.html
      format.js do
        render partial: "shared/index", locals: { records: @actions }
      end
    end
  end

  def about; end

  def react
    render file: "public/messages.html", layout: false
  end

  private

  def set_layout
    "about" if action_name == "about"
  end
end
