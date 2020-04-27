require 'rails_helper'

feature 'User can create a schedule', %q{
  In order to be able to arrange events
  As an authenticated user
  I want to be able to create a schedule
} do

  scenario 'User tries to create a schedule' do
    visit new_schedule_path
    fill_in 'Title', with: 'My schedule'
    fill_in 'Description', with: 'My own schedule for arranging events'
    click_button 'Create schedule'

    expect(page).to have_content 'Successfully created'
    expect(page).to have_content 'My schedule'
    expect(page).to have_content 'My own schedule for arranging events'
  end
end
