module ApplicationHelper
  def cp(path)
    binding.pry
    "current" if current_page?(path)
  end
end
