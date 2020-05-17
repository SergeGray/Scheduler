FactoryBot.define do
  factory :time_slot do
    schedule
    day { Time.zone.now.wday }
    sequence(:start_time) { |n| Time.zone.now.beginning_of_day + n.hours }
    sequence(:end_time) { |n| Time.zone.now.beginning_of_day + (n + 1).hours }

    trait :new do
      day { 5 }
      start_time { Time.zone.now.beginning_of_day + 8.hours }
      end_time { Time.zone.now.beginning_of_day + 9.hours + 30.minutes }
    end

    trait :invalid do
      day { nil }
      start_time { nil }
      end_time { nil }
    end
  end
end
