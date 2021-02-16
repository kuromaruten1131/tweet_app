FactoryBot.define do
  pass = Faker::Internet.password(8)
  factory :user, class: User do
    id {"1"}
    nickname {"test_user"}
    email {"test@user"}
    password {pass}
    password_confirmation {pass}
  end
  factory :another_user, class: User do
    id {"2"}
    nickname {"test_another_user"}
    email {"test@another_user"}
    password {"123456"}
    password_confirmation {password}
  end
  trait :invalid do
    nickname{nil}
  end
end
