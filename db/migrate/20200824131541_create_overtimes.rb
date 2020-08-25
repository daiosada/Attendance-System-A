class CreateOvertimes < ActiveRecord::Migration[5.1]
  def change
    create_table :overtimes do |t|
      t.date :worked_on
      t.datetime :will_finish
      t.string :note
      t.string :status, default: "なし"
      t.integer :approver
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
