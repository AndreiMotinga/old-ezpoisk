module ApplicationHelper
  def cp(path)
    "active" if request.url.include?(path)
  end

  def category_active?(category, record)
    params[:category] == category || category == record.try(:category)
  end

  def title(page_title)
    content_for(:title) { page_title }
  end

  def desc(description)
    content_for(:description) { description }
  end

  def og_url(og_url)
    content_for(:og_url) { og_url }
  end

  def og_type(og_type)
    content_for(:og_type) { og_type }
  end

  def og_image(og_image)
    content_for(:og_image) { og_image }
  end

  def home_controller?
    params[:controller] == "home"
  end

  def profiles_controller?
    params[:controller] == "profiles"
  end

  def site_link(site)
    site.match(/http/).present? ? site : "http://#{site}"
  end

  def markdown(text)
    Redcarpet::Markdown.new(
      Redcarpet::Render::HTML.new(:hard_wrap => true),
      no_intra_emphasis: true,
      fenced_code_blocks: true,
      disable_indented_code_blocks: true
    ).render(text).html_safe
  end
end
