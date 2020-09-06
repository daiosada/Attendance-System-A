class RenameChangedToAttendances < ActiveRecord::Migration[5.1]
  def change
    rename_column :attendances, :changed, :log_changed
  end
end
