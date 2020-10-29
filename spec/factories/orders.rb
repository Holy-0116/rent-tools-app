FactoryBot.define do
  factory :order do
    association :borrower_id, factory: :user
    association :item
    piece       {100}
    start_date  {'2030-1-1'}
    period      {1}
    price       {1}
  end
end
