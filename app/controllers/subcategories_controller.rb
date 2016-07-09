class SubcategoriesController < ApplicationController
  def update_subcategory
    category = attrs[:category]
    type = attrs[:type]
    @subcategories = SERVICE_CATEGORIES[category] if type == "Service"
    @subcategories = JOB_CATEGORIES[category] if type == "Job"
  end

  private

  def attrs
    params.require(:attrs)
  end
end
