class Title
  def initialize(text, title)
    @default_title = title
    @text = text
    @dot = @text.split(".").first
    @comma = @text.split(",").first
    @line = @text.split("\n|\r|<br>").first
  end

  def title
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
