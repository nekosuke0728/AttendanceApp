class CreateAttendances < ActiveRecord::Migration[5.1]
  def change
    create_table :attendances do |t|
      t.datetime :start_at
      t.datetime :end_at
      t.integer :user_id, null: false
      t.boolean :request, null: false, default: false
      t.boolean :approval, null: false, default: false
      t.boolean :edit, null: false, default: false

      t.timestamps
    end
  end
end
