# used to update subcateories depending on the category.
# used to work for both services and jobs. hence weird logic
class SubcategoriesController < ApplicationController
  def index
    category = attrs[:category]
    type = attrs[:type]
    @subcategories = Service::SUBCATEGORIES[category] if type == "Service"
  end

  private

  def attrs
    params.require(:attrs)
  end
end
