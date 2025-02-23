class CreateAttendances < ActiveRecord::Migration[8.0]
  def change
    create_table :attendances do |t|
      t.references :user, null: false, foreign_key: true
      t.references :meeting, null: false, foreign_key: true
      t.datetime :checkin_time
      t.datetime :checkout_time

      t.timestamps
    end
  end
end
