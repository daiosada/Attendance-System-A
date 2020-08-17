class AddCheckedToOneMonthAttendances < ActiveRecord::Migration[5.1]
  def change
    add_column :one_month_attendances, :checked, :boolean, default: :false
  end
end
