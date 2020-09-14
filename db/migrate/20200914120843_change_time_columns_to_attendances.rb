class ChangeTimeColumnsToAttendances < ActiveRecord::Migration[5.1]
  def change
    change_column :attendances, :started_at, :time
    change_column :attendances, :finished_at, :time
    change_column :attendances, :initial_started_at, :time
    change_column :attendances, :initial_finished_at, :time
    change_column :attendances, :changed_started_at, :time
    change_column :attendances, :changed_finished_at, :time
  end
end
