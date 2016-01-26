module ApplicationHelper
  def cp(path)
    "active" if request.url.include?(path)
  end

  def category_active?(category, record = nil)
    if params[:category] == category || category == record.try(:category)
      "active"
    end
  end

  def title(page_title)
    content_for(:title) { page_title }
  end

  def desc(description)
    content_for(:description) { description }
  end

  def services_description_meta(category, subcategory)
    category = category || "Услуги"
    desc = "eZpoisk - #{category}, #{subcategory} в США: Нью Йорке, Сан-Франциско, Лос-Анджелес, Хьюстон, Майами и др."
    content_for(:description) { desc }
  end

  def sales_description_meta(category)
    desc = "eZpoisk - Продажа #{category}, в США: Нью Йорке, Сан-Франциско, Лос-Анджелес, Хьюстон, Майами и др."
    content_for(:description) { desc }
  end
end
