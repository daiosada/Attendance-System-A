class AddApprovedAtToAttendances < ActiveRecord::Migration[5.1]
  def change
    add_column :attendances, :approved_at, :datetime
  end
end
