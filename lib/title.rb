class Title
  def initialize(text)
    @text = text
    @dot = @text.split(".").first
    @comma = @text.split(",").first
  end

  def title
    if @text.size < 51
      @text
    elsif @dot.size < 51
      @dot
    elsif @comma.size < 51
      @comma
    else
      "Работа"
    end
  end
end
