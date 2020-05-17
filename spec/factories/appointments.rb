FactoryBot.define do
  factory :appointment do
    title { 'Important meeting' }
    description { 'Everybody attend please' }
    sequence(:date) { |n| (Time.zone.now + n.weeks).strftime('%F') }
    time_slot

    trait :new do
      title { 'Not an important meeting' }
      description { 'You do not have to attend this but please do' }
    end
  end
end
