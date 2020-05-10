require 'rails_helper'

RSpec.describe TimeSlot, type: :model do
  subject { build(:time_slot) }
  let(:time_slot) { create(:time_slot) }

  it { should belong_to :schedule }

  it { should validate_inclusion_of(:day).in_range(1..7) }
  it { should validate_presence_of(:start_time) }
  it { should validate_presence_of(:end_time) }

  it 'validates start time being earlier than end time' do
    time_slot.end_time = time_slot.start_time - 1.hours
    time_slot.valid?
    expect(time_slot.errors[:end_time])
      .to contain_exactly("can't be earlier than Start time")
  end
end
