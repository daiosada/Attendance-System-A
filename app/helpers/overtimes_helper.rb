module OvertimesHelper
  
  def format_will_finish(overtime)
    if !overtime.next_day?
      "#{overtime.will_finish.hour} : #{format('%02d', overtime.will_finish.min)}"
    else
      "#{overtime.will_finish.hour + 24} : #{format('%02d', overtime.will_finish.min)}"
    end
  end
  
  def calculate_overtime(overtime, endtime)
    if !overtime.next_day?
      format("%.2f", (((overtime.will_finish.hour - endtime.hour) * 60) + (overtime.will_finish.min - endtime.min)) / 60.0)
    else
      format("%.2f", (((overtime.will_finish.hour - endtime.hour + 24) * 60) + (overtime.will_finish.min - endtime.min)) / 60.0)
    end
  end
end
