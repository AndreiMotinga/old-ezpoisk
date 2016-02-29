module HomeHelper
  # not used - not sure of efficiency
  def encoded_logo(url)
    file = open(url) {|f| f.read }
    image_tag "data:image/png;base64,#{Base64.encode64(file)}", class: "img-responsive"
  end
end
