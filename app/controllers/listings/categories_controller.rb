class Listings::CategoriesController < ApplicationController
  def index
    @categories = categories
    @subcategories = subcategories
  end

  private

  def kind_params
    params.require(:attrs).permit(:kind)
  end

  def kind
    @kind = kind_params[:kind]
  end

  def categories
    KINDS[kind][:categories]
  end

  def subcategories
    subs = KINDS[kind][:subcategories]
    return [] if kind == "services"
    subs
  end
end
