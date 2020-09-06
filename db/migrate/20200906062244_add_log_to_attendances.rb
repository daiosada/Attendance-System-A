class AddLogToAttendances < ActiveRecord::Migration[5.1]
  def change
    add_column :attendances, :initial_started_at, :datetime
    add_column :attendances, :initial_finished_at, :datetime
    add_column :attendances, :changed_started_at, :datetime
    add_column :attendances, :changed_finished_at, :datetime
    add_column :attendances, :changed, :boolean, default: false
  end
end
