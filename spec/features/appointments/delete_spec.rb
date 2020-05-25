require 'rails_helper'

feature 'User can delete an appointment', %q{
  In order to unschedule events
  As an authenticated user
  I want to be able to delete an appointment
}, js: true do
  given(:user) { create(:user) }
  given(:schedule_owner) { create(:user) }
  given(:appointment_owner) { create(:user) }
  given!(:schedule) { create(:schedule, user: schedule_owner) }
  given!(:time_slot) { create(:time_slot, schedule: schedule) }
  given!(:appointment) do
    create(:appointment, time_slot: time_slot, user: appointment_owner)
  end

  scenario 'Schedule owner tries to delete an appointment' do
    sign_in(schedule_owner)
    visit schedule_path(schedule)

    expect(page).to have_content appointment.date
    click_link 'Delete appointment'

    expect(page).to have_content 'Successfully deleted'

    within(".time-slot-#{time_slot.id}-appointments") do
      expect(page).to_not have_content appointment.date
    end
  end

  scenario 'Appointment owner tries to delete an appointment' do
    sign_in(appointment_owner)
    visit schedule_path(schedule)

    expect(page).to have_content appointment.date
    click_link 'Delete appointment'

    expect(page).to have_content 'Successfully deleted'

    within(".time-slot-#{time_slot.id}-appointments") do
      expect(page).to_not have_content appointment.date
    end
  end

  scenario 'Unauthenticated user tries to delete an appointment' do
    sign_in(user)
    visit schedule_path(schedule)

    expect(page).to_not have_link 'Delete appointment'
  end

  scenario 'Unauthenticated user tries to delete an appointment' do
    visit schedule_path(schedule)

    expect(page).to_not have_link 'Delete appointment'
  end
end
