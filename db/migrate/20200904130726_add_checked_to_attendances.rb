class AddCheckedToAttendances < ActiveRecord::Migration[5.1]
  def change
    add_column :attendances, :checked, :boolean, default: false
  end
end
