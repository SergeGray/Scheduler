require 'rails_helper'

feature 'User can delete a time slot', %q{
  In order to be able to get rid of no longer available time slots
  As an authenticated user
  I want to be able to delete a time slot
}, js: true do
  given(:user) { create(:user) }
  given!(:schedule) { create(:schedule) }
  given!(:time_slot) { create(:time_slot, schedule: schedule) }

  scenario 'Authenticated user tries to delete a time_slot' do
    sign_in(user)
    visit schedule_path(schedule)

    expect(page).to have_content time_slot.start_time.to_s(:time)
    click_link 'Delete time slot'

    expect(page).to have_content 'Successfully deleted'

    within('.time-slots') do
      expect(page).to_not have_content time_slot.start_time.to_s(:time)
    end
  end

  scenario 'Unauthenticated user tries to delete a time_slot' do
    visit schedule_path(schedule)

    expect(page).to_not have_link 'Delete time slot'
  end
end
