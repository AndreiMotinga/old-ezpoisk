class SearchesController < ApplicationController
  def index
    @documents = PgSearch.multisearch(params[:term])
                         .includes(searchable: [:city, :state, :user])
                         .page(params[:page]).per(50)

    respond_to do |format|
      format.html
      format.js { render partial: "shared/index",
                         locals: { records: @documents } }
    end
  end
end
