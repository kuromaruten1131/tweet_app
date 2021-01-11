FactoryBot.define do
  factory :tweet do
      content {"test"}
      association :user
  end
end
