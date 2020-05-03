require 'rails_helper'

RSpec.describe TimeSlotHelper, type: :helper do
  describe '#extract_time' do
    it 'returns just the time part of the Time object' do
      expect(extract_time(Time.zone.now)).to eq Time.zone.now.to_s(:time)
    end
  end
end
