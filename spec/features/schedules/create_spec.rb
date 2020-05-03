require 'rails_helper'

feature 'User can create a schedule', %q{
  In order to be able to arrange events
  As an authenticated user
  I want to be able to create a schedule
} do

  background { visit new_schedule_path }

  scenario 'User tries to create a schedule' do
    fill_in 'Title', with: 'My schedule'
    fill_in 'Description', with: 'My own schedule for arranging events'
    click_button 'Create schedule'

    expect(page).to have_content 'Successfully created'
    expect(page).to have_content 'My schedule'
    expect(page).to have_content 'My own schedule for arranging events'
  end

  scenario 'User tries to create a schedule with invalid parameters' do
    click_button 'Create schedule'

    expect(page).to have_content '2 error(s) detected:'
    expect(page).to have_content "Title can't be blank"
    expect(page).to have_content "Description can't be blank"
  end
end
