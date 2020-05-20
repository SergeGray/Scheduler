require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:schedules).dependent(:destroy) }
  it { should have_many(:appointments).dependent(:destroy) }
end
