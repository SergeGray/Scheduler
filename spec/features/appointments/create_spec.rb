require 'rails_helper'

feature 'User can create an appointment', %q{
  In order to arrange events
  As an authenticated user
  I want to be able to create an appointment
}, js: true do
  given!(:schedule) { create(:schedule) }
  given!(:time_slot) { create(:time_slot, schedule: schedule) }

  background { visit schedule_path(schedule) }

  scenario 'User tries to create an appointment' do
    click_link 'Create appointment'

    fill_in 'Title', with: 'Important meeting'
    fill_in 'Description', with: 'Everybody attend please'
    select '2020', from: 'appointment_date_1i'
    select 'December', from: 'appointment_date_2i'
    select '13', from: 'appointment_date_3i'
    select time_slot.day_and_time, from: 'appointment_time_slot_id'
    click_button 'Create appointment'

    expect(page).to have_content 'Successfully created'
    expect(page).to have_content 'Important meeting'
    expect(page).to have_content 'Everybody attend please'
    expect(page).to have_content '2020-12-13'
  end

  scenario 'User tries to create an appointment with invalid parameters'
end
