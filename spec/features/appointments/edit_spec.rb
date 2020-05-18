require 'rails_helper'

feature 'User can edit an appointment', %q{
  In order to rearrange events
  As an authenticated user
  I want to be able to edit an appointment
}, js: true do
  given!(:schedule) { create(:schedule) }
  given!(:time_slot) { create(:time_slot, schedule: schedule) }
  given!(:appointment) { create(:appointment, time_slot: time_slot) }

  context 'Authenticated user' do
    given!(:user) { create(:user) }

    background do
      sign_in(user)
      visit schedule_path(schedule)
    end

    scenario 'tries to edit an appointment' do
      click_link 'Edit appointment'

      within(".time-slot-#{time_slot.id}-appointments") do
        fill_in 'Title', with: 'Group singing'
        fill_in 'Description', with: 'Attend in the main hall'
        click_button 'Edit appointment'
      end

      expect(page).to have_content 'Successfully updated'
      expect(page).to have_content 'Group singing'
      expect(page).to have_content 'Attend in the main hall'
      expect(page).to_not have_content appointment.title
      expect(page).to_not have_content appointment.description
    end

    scenario 'tries to edit an appointment with invalid parameters' do
      click_link 'Edit appointment'

      within(".time-slot-#{time_slot.id}-appointments") do
        select '2020', from: 'appointment_date_1i'
        select Date::MONTHNAMES[appointment.date.month],
               from: 'appointment_date_2i'
        select appointment.date.day + 1, from: 'appointment_date_3i'
        select time_slot.day_and_time, from: 'appointment_time_slot_id'
        click_button 'Edit appointment'
      end

      expect(page).to have_content '1 error(s) detected'
      expect(page).to have_content(
        'Time slot day of the week does not match the Date'
      )
    end
  end

  scenario 'Unauthenticated user tries to edit an appointment' do
    visit schedule_path(schedule)

    expect(page).to_not have_link 'Edit appointment'
  end
end
