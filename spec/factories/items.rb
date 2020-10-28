FactoryBot.define do
  factory :item do
    association :user
    name             {"test"}
    explanation      {"testtest"}
    size             {"test"}
    status_id        {2}
    category_id      {2}
    delivery_fee_id  {2}
    delivery_date_id {2}
    stock            {1}
    price            {"1000"}

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
