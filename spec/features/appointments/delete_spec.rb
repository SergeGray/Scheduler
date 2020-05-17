require 'rails_helper'

feature 'User can delete an appointment', %q{
  In order to unschedule events
  As an authenticated user
  I want to be able to delete an appointment
}, js: true do
  given!(:schedule) { create(:schedule) }
  given!(:time_slot) { create(:time_slot, schedule: schedule) }
  given!(:appointment) { create(:appointment, time_slot: time_slot) }

  scenario 'User tries to delete an appointment' do
    visit schedule_path(schedule)

    expect(page).to have_content appointment.date
    click_link 'Delete appointment'

    expect(page).to have_content 'Successfully deleted'

    within(".time-slot-#{time_slot.id}-appointments") do
      expect(page).to_not have_content appointment.date
    end
  end
end
