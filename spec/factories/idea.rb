FactoryBot.define do
  
  factory :idea do
    association :user
    title {'test'}
    content {'test'}
    created_at {'xxxx'}
  end
  
end
  