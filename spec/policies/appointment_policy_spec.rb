require 'rails_helper'

describe AppointmentPolicy do
  subject { AppointmentPolicy.new(user, appointment) }

  context 'unauthenticated user' do
    let(:appointment) { create(:appointment) }
    let(:user) { nil }

    it { expect(subject.show?).to be_falsey }
    it { expect(subject.create?).to be_falsey }
    it { expect(subject.update?).to be_falsey }
    it { expect(subject.destroy?).to be_falsey }
  end

  context 'authenticated user' do
    let(:appointment) { create(:appointment) }
    let(:user) { create(:user) }

    it { expect(subject.show?).to be_falsey }
    it { expect(subject.create?).to be_truthy }
    it { expect(subject.update?).to be_falsey }
    it { expect(subject.destroy?).to be_falsey }
  end

  context 'schedule owner' do
    let(:schedule) { create(:schedule, user: user) }
    let(:time_slot) { create(:time_slot, schedule: schedule) }
    let(:appointment) { create(:appointment, time_slot: time_slot) }
    let(:user) { create(:user) }

    it { expect(subject.show?).to be_truthy }
    it { expect(subject.create?).to be_truthy }
    it { expect(subject.update?).to be_truthy }
    it { expect(subject.destroy?).to be_truthy }
  end

  context 'schedule owner' do
    let(:appointment) { create(:appointment, user: user) }
    let(:user) { create(:user) }

    it { expect(subject.show?).to be_truthy }
    it { expect(subject.create?).to be_truthy }
    it { expect(subject.update?).to be_truthy }
    it { expect(subject.destroy?).to be_truthy }
  end
end
