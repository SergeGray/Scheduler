class CreateSchedules < ActiveRecord::Migration[6.0]
  def change
    create_table :schedules do |t|
      t.string :title, null: false
      t.text :description, null: false

      t.timestamps
    end
  end
end
