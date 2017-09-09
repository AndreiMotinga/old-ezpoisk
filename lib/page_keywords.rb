class PageKeywords
  def self.from_params(params)
    new(params: params).opts_from_params
  end

  attr_reader :params, :listing

  def initialize(params: nil, listing: nil)
    @params = params
    @listing = listing
  end

  def opts_from_params
    {
      state: params[:state],
      city: params[:city],
      tags: tags
    }
  end

  private

  def tags
    [params[:kind],
     params[:category],
     params[:subcategory].try(:split, "--")].flatten.compact
  end
end
