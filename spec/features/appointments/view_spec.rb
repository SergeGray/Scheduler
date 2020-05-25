require 'rails_helper'

feature 'User can view an appointment', %q{
  In order to be able to see information about a scheduled event
  As an authenticated user
  I want to be able to view an appointment
} do
  given(:user) { create(:user) }
  given(:schedule_owner) { create(:user) }
  given(:appointment_owner) { create(:user) }
  given!(:schedule) { create(:schedule, user: schedule_owner) }
  given!(:time_slot) { create(:time_slot, schedule: schedule) }
  given!(:appointment) do
    create(:appointment, time_slot: time_slot, user: appointment_owner)
  end

  scenario 'Appointment owner tries to view an appointment' do
    sign_in(appointment_owner)
    visit appointment_path(appointment)

    expect(page).to have_content appointment.title
    expect(page).to have_content appointment.description
    expect(page).to have_content appointment.date
    expect(page).to have_content appointment.time_slot.day_and_time
  end

  scenario 'Schedule owner tries to view an appointment' do
    sign_in(schedule_owner)
    visit appointment_path(appointment)

    expect(page).to have_content appointment.title
    expect(page).to have_content appointment.description
    expect(page).to have_content appointment.date
    expect(page).to have_content appointment.time_slot.day_and_time
  end

  scenario "Authenticated user tries to view someone else's appointment" do
    sign_in(user)
    visit appointment_path(appointment)

    expect(page).to_not have_content appointment.title
    expect(page).to_not have_content appointment.description
    expect(page).to_not have_content appointment.date
    expect(page).to_not have_content appointment.time_slot.day_and_time
  end

  scenario 'Unauthenticated user tries to view an appointment' do
    visit appointment_path(appointment)

    expect(page).to_not have_content appointment.title
    expect(page).to_not have_content appointment.description
    expect(page).to_not have_content appointment.date
    expect(page).to_not have_content appointment.time_slot.day_and_time
  end
end
