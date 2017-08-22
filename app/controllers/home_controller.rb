# frozen_string_literal: true

class HomeController < PagesController
  layout :set_layout
  after_action(only: :index) { create_show_impressions(@actions.map(&:actionable)) }

  def index
    @actions = Action.includes(actionable: :user)
                     .order(updated_at: :desc)
                     .page(params[:page])
    @popular = Post.order(created_at: :desc).take(5)
    @top, @left, @right = Partner.get
    respond_to do |format|
      format.html
      format.js do
        render partial: "shared/index", locals: { records: @actions }
      end
    end
  end

  def about; end

  private

  def set_layout
    "about" if action_name == "about"
  end
end
