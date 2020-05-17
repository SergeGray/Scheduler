require 'rails_helper'

RSpec.describe TimeSlotsHelper, type: :helper do
  describe '#extract_time' do
    it 'returns just the time part of the Time object' do
      expect(extract_time(Time.zone.now)).to eq Time.zone.now.to_s(:time)
    end
  end

  describe '#day_of_week_select' do
    it 'returns options_for select for days of the week' do
      expect(day_of_the_week_select).to eq(
        options_for_select(
          Date::DAYNAMES.map.with_index { |day, index| [day, index] }
        )
      )
    end
  end
end
