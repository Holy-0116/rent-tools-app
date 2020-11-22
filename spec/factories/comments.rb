FactoryBot.define do
  factory :comment do
    association :item
    association :borrower, factory: :user
    text {"testtest"}
  end
end
