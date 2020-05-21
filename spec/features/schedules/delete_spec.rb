require 'rails_helper'

feature 'User can delete a schedule', %q{
  In order to be able to get rid of no longer needed schedules
  As an authenticated user
  I want to be able to delete a schedule
} do
  given(:user) { create(:user) }
  given(:owner) { create(:user) }
  given!(:schedule) { create(:schedule, user: owner) }

  scenario 'Schedule owner tries to delete a schedule' do
    sign_in(owner)
    visit schedule_path(schedule)
    click_link 'Delete schedule'

    expect(page).to have_content 'Successfully deleted'
    expect(page).to_not have_content 'My schedule'
  end

  scenario "Authenticated user tries to edit someone else's schedule" do
    sign_in(user)
    visit schedule_path(schedule)

    expect(page).to_not have_link 'Delete schedule'
  end

  scenario 'Unauthenticated user tries to delete a schedule' do
    visit schedule_path(schedule)

    expect(page).to_not have_link 'Delete schedule'
  end
end
