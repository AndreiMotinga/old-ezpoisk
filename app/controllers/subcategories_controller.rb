class SubcategoriesController < ApplicationController
  def update_subcategory
    category = subcategory_params
    @subcategories = SERVICE_CATEGORIES[category]
  end

  private

  def subcategory_params
    params.require(:category).to_sym
  end
end
