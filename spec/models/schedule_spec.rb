require 'rails_helper'

RSpec.describe Schedule, type: :model do
  it { should have_many(:time_slots).dependent :destroy }

  it { should validate_presence_of :title }
  it { should validate_presence_of :description }
end
