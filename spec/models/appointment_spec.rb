require 'rails_helper'

RSpec.describe Appointment, type: :model do
  it { should belong_to(:time_slot) }

  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:date) }
end
