require 'rails_helper'

feature 'User can edit a schedule', %q{
  In order to be able to change wrong or outdated information
  As an owner of a schedule
  I want to be able to edit that schedule
} do
  given(:user) { create(:user) }
  given(:owner) { create(:user) }
  given(:schedule) { create(:schedule, user: owner) }

  context 'Schedule owner' do
    background do
      sign_in(owner)
      visit schedule_path(schedule)
      click_link 'Edit schedule'
    end

    scenario 'tries to edit a schedule' do
      fill_in 'Title', with: 'Cool schedule'
      fill_in 'Description', with: 'This schedule is cool'
      click_button 'Edit schedule'

      expect(page).to have_content 'Successfully updated'
      expect(page).to_not have_content schedule.title
      expect(page).to_not have_content schedule.description
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

  scenario "Authenticated user tries to edit someone else's schedule" do
    sign_in(user)
    visit schedule_path(schedule)
    expect(page).to_not have_link 'Edit schedule'
  end

  scenario 'Unauthenticated user tries to edit a schedule' do
    visit schedule_path(schedule)

    expect(page).to_not have_link 'Edit schedule'
  end
end
