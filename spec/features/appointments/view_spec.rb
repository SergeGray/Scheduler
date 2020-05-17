require 'rails_helper'

feature 'User can view an appointment', %q{
  In order to be able to see information about a scheduled event
  As an authenticated user
  I want to be able to view an appointment
} do
  given!(:appointment) { create(:appointment) }

  scenario 'User tries to view an appointment' do
    visit appointment_path(appointment)

    expect(page).to have_content appointment.title
    expect(page).to have_content appointment.description
    expect(page).to have_content appointment.date
    expect(page).to have_content appointment.time_slot.day_and_time
  end
end
