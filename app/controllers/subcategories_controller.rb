class SubcategoriesController < ApplicationController
  def update_subcategory
    category = params[:category].to_sym
    @subcategories = ServiceCategories[category]
    @id = params[:id]
  end
end
