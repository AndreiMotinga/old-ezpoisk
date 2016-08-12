module ApplicationHelper
  def cp(path)
    "active" if request.url.include?(path)
  end

  def category_active?(category, record)
    params[:category] == category || category == record.try(:category)
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
