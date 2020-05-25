require 'rails_helper'

describe SchedulePolicy do
  subject { SchedulePolicy.new(user, schedule) }

  context 'unauthenticated user' do
    let(:schedule) { create(:schedule) }
    let(:user) { nil }

    it { expect(subject.show?).to be_truthy }
    it { expect(subject.create?).to be_falsey }
    it { expect(subject.update?).to be_falsey }
    it { expect(subject.destroy?).to be_falsey }
  end

  context 'authenticated user' do
    let(:schedule) { create(:schedule) }
    let(:user) { create(:user) }

    it { expect(subject.show?).to be_truthy }
    it { expect(subject.create?).to be_truthy }
    it { expect(subject.update?).to be_falsey }
    it { expect(subject.destroy?).to be_falsey }
  end

  context 'schedule owner' do
    let(:schedule) { create(:schedule, user: user) }
    let(:user) { create(:user) }

    it { expect(subject.show?).to be_truthy }
    it { expect(subject.create?).to be_truthy }
    it { expect(subject.update?).to be_truthy }
    it { expect(subject.destroy?).to be_truthy }
  end
end
