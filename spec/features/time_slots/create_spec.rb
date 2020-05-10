require 'rails_helper'

feature 'User can create a time_slot', %q{
  In order to manage time
  As an authenticated user
  I want to be able to create a time slot
}, js: true do
  given!(:schedule) { create(:schedule) }

  background { visit schedule_path(schedule) }

  scenario 'User tries to create a time slot' do
    expect(page).to_not have_content '18:00'
    expect(page).to_not have_content '20:30'

    click_link 'Add time slot'

    select 'Monday', from: 'Day'
    select '18', from: 'time_slot_start_time_4i'
    select '00', from: 'time_slot_start_time_5i'
    select '20', from: 'time_slot_end_time_4i'
    select '30', from: 'time_slot_end_time_5i'
    click_button 'Create time slot'

    expect(page).to have_content 'Successfully created'
    expect(page).to have_content 'Monday'
    expect(page).to have_content '18:00'
    expect(page).to have_content '20:30'
  end

  scenario 'User tries to create a time slot with invalid parameters' do
    click_link 'Add time slot'

    select '22', from: 'time_slot_start_time_4i'
    select '22', from: 'time_slot_start_time_5i'
    select '11', from: 'time_slot_end_time_4i'
    select '11', from: 'time_slot_end_time_5i'

    click_button 'Create time slot'

    expect(page).to have_content "End time can't be earlier than Start time"
    expect(page).to_not have_content '22:22'
    expect(page).to_not have_content '11:11'
  end
end
