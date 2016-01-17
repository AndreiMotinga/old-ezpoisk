module ApplicationHelper
  def cp(path)
    "active" if current_page?(path)
  end

  def title(page_title)
    content_for(:title) { page_title }
  end
end
