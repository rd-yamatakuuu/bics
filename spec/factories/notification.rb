FactoryBot.define do
  factory :notification do
    visitor_id {FactoryBot.create(:user).id }
    visited_id {FactoryBot.create(:user).id }
    association :idea
    association :comment
    association :chat
    association :room
    action {'test'}
    checked {'false'}
  end
end