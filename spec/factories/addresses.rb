FactoryBot.define do
  factory :address do
    association   :user
    postal_code   {"1008111"}
    prefecture_id {"13"}
    city_name     {"千代田区千代田"}
    house_number  {"1-1"}
    building_name {"皇居"}
    phone_number  {"0332131111"}
  end
end
