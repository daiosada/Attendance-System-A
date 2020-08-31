class AddCheckedToOvertimes < ActiveRecord::Migration[5.1]
  def change
    add_column :overtimes, :checked, :boolean, default: false
  end
end
