class SocialTitle
  REGEX = /\.|,|\n|\r|<br>/
  def initialize(text, title = "")
    @default_title = title
    @text = text
    @dot = @text.split(".").first
    @comma = @text.split(",").first
    @line = @text.split("").first
  end

  def title
    substring.mb_chars.downcase.capitalize.strip.to_s
  end

  private

  def substring
    if @text.size < 51
      @text
    elsif @dot.size < 51
      @dot
    elsif @comma.size < 51
      @comma
    else
      @default_title
    end
  end
end
