require 'rails_helper'

feature 'User can edit a time_slot', %q{
  In order to rearragnge upcoming events
  As an authenticated user
  I want to be able to edit a time slot
} do
  given!(:schedule) { create(:schedule) }
  given!(:time_slot) { create(:time_slot, schedule: schedule) }

  scenario 'User tries to create a time slot' do
    visit schedule_path(schedule)

    expect(page).to_not have_content '14:00'
    expect(page).to_not have_content '15:30'

    click_link 'Edit time slot'

    within('.time_slots') do
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
end
