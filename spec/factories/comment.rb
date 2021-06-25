FactoryBot.define do
  factory :comment do
    association :user
    association :idea
    comment {'text'}
    review {'1'}
  end
end