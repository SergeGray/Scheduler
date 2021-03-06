require 'rails_helper'

feature 'User can edit a time_slot', %q{
  In order to rearragnge upcoming events
  As an authenticated user
  I want to be able to edit a time slot
}, js: true do
  given(:user) { create(:user) }
  given(:owner) { create(:user) }
  given!(:schedule) { create(:schedule, user: owner) }
  given!(:time_slot) { create(:time_slot, schedule: schedule) }

  context 'Schedule owner' do
    background do
      sign_in(owner)
      visit schedule_path(schedule)
    end

    scenario 'tries to edit a time slot' do
      expect(page).to_not have_content '14:00'
      expect(page).to_not have_content '15:30'

      click_link 'Edit time slot'

      within('.time-slots') do
        select 'Tuesday', from: 'Day'
        select '14', from: 'time_slot_start_time_4i'
        select '00', from: 'time_slot_start_time_5i'
        select '15', from: 'time_slot_end_time_4i'
        select '30', from: 'time_slot_end_time_5i'
        click_button 'Edit time slot'
      end

      expect(page).to have_content 'Successfully updated'
      expect(page).to have_content 'Tuesday'
      expect(page).to have_content '14:00'
      expect(page).to have_content '15:30'
    end

    scenario 'tries to edit a time slot with invalid parameters' do
      click_link 'Edit time slot'

      within('.time-slots') do
        select '15', from: 'time_slot_start_time_4i'
        select '55', from: 'time_slot_start_time_5i'
        select '11', from: 'time_slot_end_time_4i'
        select '11', from: 'time_slot_end_time_5i'
        click_button 'Edit time slot'
      end

      expect(page).to have_content "End time can't be earlier than Start time"
      expect(page).to_not have_content '15:55'
      expect(page).to_not have_content '11:11'
    end
  end

  scenario "Authenticated user tries to edit a time slot "\
           "on someone else's schedule" do
    sign_in(user)
    visit schedule_path(schedule)

    expect(page).to_not have_link 'Edit time slot'
  end

  scenario 'Unauthenticated user tries to edit a time slot' do
    visit schedule_path(schedule)

    expect(page).to_not have_link 'Edit time slot'
  end
end
