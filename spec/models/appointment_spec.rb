require 'rails_helper'

RSpec.describe Appointment, type: :model do
  subject { build(:appointment) }
  let(:time_slot) { build(:time_slot) }
  let(:appointment) do
    build(:appointment, time_slot: time_slot, date: '2020-05-15')
  end

  it { should belong_to(:time_slot) }

  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:date) }
  it { should validate_uniqueness_of(:date).scoped_to(:time_slot_id) }

  it 'allows time slot with day of the week matching the date' do
    time_slot.day = 5
    expect(appointment).to be_valid
  end

  it 'disallows time slot with day of the week not matching the date' do
    time_slot.day = 0
    appointment.valid?
    expect(appointment.errors[:time_slot])
      .to contain_exactly('day of the week does not match the Date')
  end
end
