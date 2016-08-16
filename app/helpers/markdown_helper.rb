module MarkdownHelper
  class HTMLwithPygments < Redcarpet::Render::HTML
    def autolink(link, link_type)
      case link_type
      when :url then url_link(link)
      end
    end
    def url_link(link)
      if link.include?("https://www.youtube.com")
        youtube_link(link)
      else
        normal_link(link)
      end
    end
    def youtube_link(link)
      parameters_start = link.index('=')
      video_id = link[parameters_start + 1..-1]
      "<iframe width=\"100%\" height=\"400\" src=\"https://www.youtube.com/embed/#{video_id}?autoplay=0\" allowfullscreen></iframe>"
    end
    def normal_link(link)
      "<a href=\"#{link}\" target=\"_blank\">#{link}</a>"
    end
  end

  def markdown(text)
    options = {
      escape_html:     true,
      hard_wrap:       true,
      link_attributes: { rel: 'nofollow', target: "_blank" },
      space_after_headers: true,
      fenced_code_blocks: true
    }

    extensions = {
      autolink:           true,
      superscript:        true,
      disable_indented_code_blocks: true
    }

    renderer = HTMLwithPygments.new(options)
    markdown = Redcarpet::Markdown.new(renderer, extensions)
    markdown.render(text).html_safe
  end
end
