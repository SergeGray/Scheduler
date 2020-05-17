require 'rails_helper'

RSpec.describe TimeSlot, type: :model do
  subject { build(:time_slot) }
  let(:time_slot) { build(:time_slot, day: 5) }

  it { should have_many(:appointments).dependent(:destroy) }

  it { should belong_to :schedule }

  it { should validate_inclusion_of(:day).in_range(0..6) }
  it { should validate_presence_of(:start_time) }
  it { should validate_presence_of(:end_time) }

  it 'validates start time being earlier than end time' do
    time_slot.end_time = time_slot.start_time - 1.hours
    time_slot.valid?
    expect(time_slot.errors[:end_time])
      .to contain_exactly("can't be earlier than Start time")
  end

  describe '#day_and_time' do
    it 'returns a string of time slot day of the week and time' do
      expect(time_slot.day_and_time).to eq(
        "#{time_slot.day_of_the_week}, "\
        "#{time_slot.start_time.to_s(:time)} - "\
        "#{time_slot.end_time.to_s(:time)}"
      )
    end
  end

  describe '#day_of_the_week' do
    it 'returns the name of the day of the week by a number' do
      time_slot.day = 5
      expect(time_slot.day_of_the_week).to eq('Friday')
    end
  end
end
