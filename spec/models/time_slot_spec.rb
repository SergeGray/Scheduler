require 'rails_helper'

RSpec.describe TimeSlot, type: :model do
  it { should belong_to :schedule }

  it { should validate_inclusion_of(:day).in_range(1..7) }
  it { should validate_presence_of(:start_time) }
  it { should validate_presence_of(:end_time) }
end
