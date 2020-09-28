FactoryBot.define do
  factory :item do
    association :user
    name             {"test"}
    explanation      {"testtest"}
    size             {"test"}
    status_id        {"2"}
    category_id      {"2"}
    delivery_fee_id  {"2"}
    delivery_date_id {"2"}
    price            {"1000"}
  end
end
