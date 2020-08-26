class ChangeNextDayOfOvertimes < ActiveRecord::Migration[5.1]
  def up
    change_column :overtimes, :next_day, :boolean, default: false
  end
  
  def down
    change_column :overtimes, :next_day, :boolean
  end
end
