require 'rails_helper'

feature 'User can edit a schedule', %q{
  In order to be able to change wrong or outdated information
  As an authenticated user
  I want to be able to edit a schedule
} do
  given(:user) { create(:user) }
  given(:schedule) do
    create(:schedule, title: 'My schedule', description: 'My own schedule')
  end

  context 'Authenticated user' do
    background do
      sign_in(user)
      visit schedule_path(schedule)
      click_link 'Edit schedule'
    end

    scenario 'tries to edit a schedule' do
      fill_in 'Title', with: 'Cool schedule'
      fill_in 'Description', with: 'This schedule is cool'
      click_button 'Edit schedule'

      expect(page).to have_content 'Successfully updated'
      expect(page).to_not have_content 'My schedule'
      expect(page).to_not have_content 'My own schedule'
      expect(page).to have_content 'Cool schedule'
      expect(page).to have_content 'This schedule is cool'
    end

    scenario 'tries to edit a schedule with errors' do
      fill_in 'Title', with: ''
      click_button 'Edit schedule'

      expect(page).to have_content '1 error(s) detected:'
      expect(page).to have_content "Title can't be blank"
    end
  end

  scenario 'Unauthenticated user tries to edit a schedule' do
    visit schedule_path(schedule)

    expect(page).to_not have_link 'Edit schedule'
  end
end
