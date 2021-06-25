FactoryBot.define do
  factory :contact do
    name {'text'}
    email {'test@test.com'}
    contact_message {'test'}
    judge {'false'}
  end
end