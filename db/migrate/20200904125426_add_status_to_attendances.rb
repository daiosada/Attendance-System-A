class AddStatusToAttendances < ActiveRecord::Migration[5.1]
  def change
    add_column :attendances, :status, :string, default: "なし"
  end
end
