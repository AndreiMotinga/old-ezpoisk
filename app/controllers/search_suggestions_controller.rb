class SearchSuggestionsController < ApplicationController
  def index
    render json: Question.term_for(params[:term])
  end
end
