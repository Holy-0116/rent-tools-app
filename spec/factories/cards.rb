FactoryBot.define do
  factory :card do
    association :user
    card_token        {"tok_f60baca131e8587e692798c7809b"}
    customer_token    {"cus_22c9c6fd89310c79976b592edf30"}
  end
end
