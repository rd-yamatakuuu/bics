FactoryBot.define do
  
  factory :idea_tag do
    association :idea
    association :tag
  end
end