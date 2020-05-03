require 'rails_helper'

feature 'User can delete a schedule', %q{
  In order to be able to get rid of no longer needed schedules
  As an authenticated user
  I want to be able to delete a schedule
} do

  given!(:schedule) { create(:schedule) }

  scenario 'User tries to delete a schedule' do
    visit schedule_path(schedule)
    click_link 'Delete schedule'

    expect(page).to have_content 'Successfully deleted'
    expect(page).to_not have_content 'My schedule'
  end
end
