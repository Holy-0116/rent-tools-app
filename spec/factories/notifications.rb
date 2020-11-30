FactoryBot.define do
  factory :notification do
    association   :visitor, factory: :user
    association   :visited, factory: :user
    association   :item
    association   :comment
    association   :order
    action        {"comment"}
    checked       {"false"}
  end
end
