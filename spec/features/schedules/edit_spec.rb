require 'rails_helper'

feature 'User can edit a schedule', %q{
  In order to be able to change wrong or outdated information
  As an authenticated user
  I want to be able to edit a schedule
} do

  given(:schedule) do
    create(:schedule, title: 'My schedule', description: 'My own schedule')
  end

  scenario 'User tries to edit a schedule' do
    visit edit_schedule_path(schedule)
    fill_in 'Title', with: 'Cool schedule'
    fill_in 'Description', with: 'This schedule is cool'
    click_button 'Edit schedule'

    expect(page).to have_content 'Successfully updated'
    expect(page).to_not have_content 'My schedule'
    expect(page).to_not have_content 'My own schedule'
    expect(page).to have_content 'Cool schedule'
    expect(page).to have_content 'This schedule is cool'
  end
end
