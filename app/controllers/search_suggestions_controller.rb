class SearchSuggestionsController < ApplicationController
  def index
    render json: SearchSuggestion.term_for(params[:term])
  end
end
