FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }
    password { 'password1' }
    password_confirmation { 'password1' }
  end
end
