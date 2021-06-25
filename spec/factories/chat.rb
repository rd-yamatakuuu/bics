FactoryBot.define do
  factory :chat do
    association :user
    association :room
    message {'text'}
  end
end