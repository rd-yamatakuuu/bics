FactoryBot.define do

  factory :admin do
    email {'test@test.com'}
    password {'password'}
    password_confirmation {'password'}
  end

end