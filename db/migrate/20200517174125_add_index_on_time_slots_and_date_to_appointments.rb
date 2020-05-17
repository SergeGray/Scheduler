class AddIndexOnTimeSlotsAndDateToAppointments < ActiveRecord::Migration[6.0]
  def change
    add_index :appointments, %i[time_slot_id date], unique: true
  end
end
