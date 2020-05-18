require 'rails_helper'

feature 'User can create an appointment', %q{
  In order to arrange events
  As an authenticated user
  I want to be able to create an appointment
}, js: true do
  given(:user) { create(:user) }
  given!(:schedule) { create(:schedule) }
  given!(:time_slot) { create(:time_slot, day: 0, schedule: schedule) }

  context 'Authenticated user' do
    background do
      sign_in(user)
      visit schedule_path(schedule)
    end

    scenario 'tries to create an appointment' do
      click_link 'Create appointment'

      fill_in 'Title', with: 'Important meeting'
      fill_in 'Description', with: 'Everybody attend please'
      select '2020', from: 'appointment_date_1i'
      select 'May', from: 'appointment_date_2i'
      select '17', from: 'appointment_date_3i'
      select time_slot.day_and_time, from: 'appointment_time_slot_id'
      click_button 'Create appointment'

      expect(page).to have_content 'Successfully created'
      expect(page).to have_content 'Important meeting'
      expect(page).to have_content 'Everybody attend please'
      expect(page).to have_content '2020-05-17'
    end

    scenario 'tries to create an appointment with invalid parameters' do
      click_link 'Create appointment'
      click_button 'Create appointment'

      expect(page).to have_content '3 error(s) detected'
      expect(page).to have_content 'Time slot must exist'
      expect(page).to have_content "Title can't be blank"
      expect(page).to have_content "Description can't be blank"
    end
  end

  scenario 'Unauthenticated user tries to create an appointment' do
    visit schedule_path(schedule)

    expect(page).to_not have_link 'Create appointment'
  end
end
