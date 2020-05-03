FactoryBot.define do
  factory :schedule do
    title { 'Board meetings' }
    description { 'Organization of board meetings' }

    trait :new do
      title { 'Concert Hall rent' }
      description { 'Renting hours for the Concert Hall' }
    end
  end
end
