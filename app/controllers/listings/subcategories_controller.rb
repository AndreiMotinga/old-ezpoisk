class Listings::SubcategoriesController < ApplicationController
  def index
    @subcategories = KINDS[:services][:subcategories][category]
  end

  private

  def category_param
    params.require(:attrs).permit(:category)
  end

  def category
    category_param[:category]
  end
end
