require 'rails_helper'

RSpec.describe TimeSlotsHelper, type: :helper do
  describe '#extract_time' do
    it 'returns just the time part of the Time object' do
      expect(extract_time(Time.zone.now)).to eq Time.zone.now.to_s(:time)
    end
  end

  describe '#day_of_week_select' do
    it 'returns options_for select for days of the week' do
      expect(day_of_week_select).to eq(
        options_for_select(
          [
            ['Monday', 1],
            ['Tuesday', 2],
            ['Wednesday', 3],
            ['Thursday', 4],
            ['Friday', 5],
            ['Saturday', 6],
            ['Sunday', 7]
          ]
        )
      )
    end
  end
end
