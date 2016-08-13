module ApplicationHelper
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
