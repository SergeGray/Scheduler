FactoryBot.define do
  factory :appointment do
    title { 'Important meeting' }
    description { 'Everybody attend please' }
    date { '2020-05-10' }
    time_slot
  end
end
