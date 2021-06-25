FactoryBot.define do
  factory :user do
    name {'test'}
    kana_name {'test'}
    email {'test@test.com'}
    introduction {'test'}
    postal_code {'1111111'}
    address {'test'}
    password {'password'}
    password_confirmation {'password'}
    status {'false'}
    mentor_check {'false'}
  end
end