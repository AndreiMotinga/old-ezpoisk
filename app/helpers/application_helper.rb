module ApplicationHelper
  def cp(path)
    "active" if current_page?(path)
  end

  def distance_array
    [1, 5, 10, 25, 50, 100, 150, 200, 300, 500]
  end
end
