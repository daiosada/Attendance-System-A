class CreateOneMonthAttendances < ActiveRecord::Migration[5.1]
  def change
    create_table :one_month_attendances do |t|
      t.date :month
      t.string :status, default: "なし"
      t.integer :approver
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
