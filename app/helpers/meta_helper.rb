module MetaHelper
  def title(text)
    content_for(:title) { text }
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
end
