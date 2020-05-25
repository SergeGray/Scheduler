require 'rails_helper'

describe TimeSlotPolicy do
  subject { TimeSlotPolicy.new(user, time_slot) }

  context 'unauthenticated user' do
    let(:time_slot) { create(:time_slot) }
    let(:user) { nil }

    it { expect(subject.create?).to be_falsey }
    it { expect(subject.update?).to be_falsey }
    it { expect(subject.destroy?).to be_falsey }
  end

  context 'authenticated user' do
    let(:time_slot) { create(:time_slot) }
    let(:user) { create(:user) }

    it { expect(subject.create?).to be_falsey }
    it { expect(subject.update?).to be_falsey }
    it { expect(subject.destroy?).to be_falsey }
  end

  context 'schedule owner' do
    let(:schedule) { create(:schedule, user: user) }
    let(:time_slot) { create(:time_slot, schedule: schedule) }
    let(:user) { create(:user) }

    it { expect(subject.create?).to be_truthy }
    it { expect(subject.update?).to be_truthy }
    it { expect(subject.destroy?).to be_truthy }
  end
end
