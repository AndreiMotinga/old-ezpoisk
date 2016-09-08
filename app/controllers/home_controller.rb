class HomeController < ApplicationController
  layout :resolve_layout

  def index
    @entries = Entry.includes(enterable: [:user, :taggings])
                    .news
                    .desc
                    .page(params[:page]).per(10)

    respond_to do |format|
      format.html
      format.js { render partial: "shared/index",
                         locals: { records: @entries } }
    end

    IncreaseImpressionsJob.perform_in(
      1.minute,
      @entries.select{|e| e.enterable_type == "Answer"}.map(&:enterable_id),
      "Answer"
    )
    IncreaseImpressionsJob.perform_in(
      1.minute,
      @entries.select{|e| e.enterable_type == "Post"}.map(&:enterable_id),
      "Post"
    )
  end

  def about
  end

  def contacts
  end

  def clean
  end

  private

  def resolve_layout
    "plain" if action_name == "clean"
  end
end
