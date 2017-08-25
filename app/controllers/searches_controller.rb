class SearchesController < PagesController
  def index
    type = params[:t]
    @documents = PgSearch.multisearch(params[:term])
    @documents = @documents.where(searchable_type: type) if type.present?
    if type == "Listing"
      @documents = @documents.includes(searchable: %I[city state])
    elsif %w[Answer Post].include?(type)
      @documents = @documents.includes(searchable: :user)
    end
    @documents = @documents.order(:created_at).page(params[:page])

    respond_to do |format|
      format.html
      format.js { render partial: "shared/index",
                         locals: { records: @documents } }
    end
  end
end
