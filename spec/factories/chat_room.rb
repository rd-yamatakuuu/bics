FactoryBot.define do
  factory :chat_room do
    association :room
    association :user
  end
end