FactoryBot.define do
  factory :favorite do
    association :user
    association :idea
  end
end