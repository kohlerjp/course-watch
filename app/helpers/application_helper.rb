module ApplicationHelper
  def full_title(title)
    base = "Course Watch"
    if title.empty?
      return base
    else
      return "#{base} | #{title}"
    end
  end
end
