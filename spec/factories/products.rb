FactoryBot.define do
  factory :product do
    association :category
    sequence(:name) { |n| "fruit#{n}" }
    # name { "test" }
    description { "この果物は美味しい" }
  end
end
