FactoryBot.define do
  factory :user_speciality do
    association :user
    association :speciality
  end
end