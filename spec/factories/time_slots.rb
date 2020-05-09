FactoryBot.define do
  factory :time_slot do
    schedule
    sequence(:day) { |n| n % 7 + 1 }
    sequence(:start_time) { |n| Time.zone.now + n.hours }
    sequence(:end_time) { |n| Time.zone.now + (n + 1).hours }

    trait :new do
      day { 5 }
      start_time { Time.zone.now.beginning_of_day + 8.hours }
      end_time { Time.zone.now.beginning_of_day + 9.hours + 30.minutes }
    end
  end
end
