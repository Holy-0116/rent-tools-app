FactoryBot.define do
  factory :user do
    name                   {"山田太郎"}
    email                  {Faker::Internet.free_email}
    password               {"test1234"}
    password_confirmation  {password}
    company_name           {"株式会社テスト"}
    
  end
end
