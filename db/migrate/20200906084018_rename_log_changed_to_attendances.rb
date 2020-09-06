class RenameLogChangedToAttendances < ActiveRecord::Migration[5.1]
  def change
    rename_column :attendances, :log_changed, :approved
  end
end
