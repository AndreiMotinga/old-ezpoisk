class Listings::SubcategoriesController < ApplicationController
  def index
    @subcategories = RU_KINDS["услуги"][:subcategories][category]
  end

  private

  def category_param
    params.require(:attrs).permit(:category)
  end

  def category
    category_param[:category]
  end
end
