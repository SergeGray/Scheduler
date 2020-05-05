require 'rails_helper'

feature 'User can view time slots', %q{
  In order to be able to see the available hours on a schedule
  As an authenticated user
  I want to be able to view time slots
} do

  given!(:schedule) { create(:schedule) }
  given!(:time_slots) { create_list(:time_slot, 2, schedule: schedule) }

  scenario 'User tries to view a list of time slots' do
    visit schedule_path(schedule)

    time_slots.each do |time_slot|
      expect(page).to have_content time_slot.day
      expect(page).to have_content time_slot.start_time.to_s(:time)
      expect(page).to have_content time_slot.end_time.to_s(:time)
    end
  end
end