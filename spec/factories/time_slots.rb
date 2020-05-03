FactoryBot.define do
  factory :time_slot do
    schedule
    sequence(:day) { |n| n % 7 + 1 }
    sequence(:start_time) { |n| Time.zone.now + n.hours }
    sequence(:end_time) { |n| Time.zone.now + (n + 1).hours }
  end
end
