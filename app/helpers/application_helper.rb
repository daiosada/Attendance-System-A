module ApplicationHelper
  
  def full_title(page_name = "")
    base_title = "AttendanceApp"
    if page_name.empty?
      base_title
    else
      page_name + " | " + base_title
    end
  end
  
  def weekend(day)
    if day.saturday?
      'saturday'
    elsif day.sunday?
      'sunday'
    end
  end
end
