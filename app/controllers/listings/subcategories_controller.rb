class Listings::SubcategoriesController < ApplicationController
  def index
    category = category_param[:category]
    @subcategories = RU_KINDS["услуги"][:subcategories][category]
  end

  private

  def category_param
    params.require(:attrs).permit(:category)
  end
end
