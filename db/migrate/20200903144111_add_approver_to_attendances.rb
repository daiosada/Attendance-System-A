class AddApproverToAttendances < ActiveRecord::Migration[5.1]
  def change
    add_column :attendances, :approver, :integer
  end
end
