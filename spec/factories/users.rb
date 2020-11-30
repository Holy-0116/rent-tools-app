FactoryBot.define do
  factory :user do
    name                   {Faker::Name.name}
    email                  {Faker::Internet.free_email}
    password               {"test1234"}
    password_confirmation  {password}
    company_name           {"株式会社テスト"}
    
  end
end
