class AddNextDayToOvertimes < ActiveRecord::Migration[5.1]
  def change
    add_column :overtimes, :next_day, :boolean, default: false
  end
end
