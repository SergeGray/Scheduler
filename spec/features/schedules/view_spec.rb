require 'rails_helper'

feature 'User can view a schedule', %q{
  In order to be able to see my arranged events
  As an authenticated user
  I want to be able to view a schedule
} do

  given(:schedule) { create(:schedule) }

  scenario 'User tries to view a schedule' do
    visit schedule_path(schedule)

    expect(page).to have_content schedule.title
    expect(page).to have_content schedule.description
  end
end
