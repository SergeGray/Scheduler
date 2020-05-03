require 'rails_helper'

feature 'User can view a schedule', %q{
  In order to be able to see my arranged events
  As an authenticated user
  I want to be able to view schedules
} do

  given!(:schedule) { create(:schedule) }
  given!(:schedule2) { create(:schedule, :new) }

  scenario 'User tries to view a list of schedules' do
    visit schedules_path

    expect(page).to have_content schedule.title
    expect(page).to have_content schedule2.title
  end

  scenario 'User tries to view a schedule' do
    visit schedule_path(schedule)

    expect(page).to have_content schedule.title
    expect(page).to have_content schedule.description
  end
end
