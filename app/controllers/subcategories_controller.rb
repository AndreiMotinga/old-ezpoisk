class SubcategoriesController < ApplicationController
  def update_subcategory
    category = params[:category].to_sym
    @subcategories = SERVICE_CATEGORIES[category]
  end
end
