FactoryBot.define do
  factory :product do
    association :category
    sequence(:name) { |n| "fruit#{n}" }
    category_id { 1 }
    description { "この果物は美味しい" }
  end
end
