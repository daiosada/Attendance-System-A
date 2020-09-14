class ChangeColumnsToAttendances < ActiveRecord::Migration[5.1]
  def change
    change_column :attendances, :started_at, :datetime
    change_column :attendances, :finished_at, :datetime
    change_column :attendances, :changed_started_at, :datetime
    change_column :attendances, :changed_finished_at, :datetime
  end
end
