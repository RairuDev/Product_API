# frozen_string_literal: true

# == Schema Information
#
# Table name: products
#
#  id          :integer          not null, primary key
#  description :text             not null
#  name        :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :bigint           not null
#
# Indexes
#
#  index_products_on_name  (name) UNIQUE
#
FactoryBot.define do
  factory :product do
    association :category
    sequence(:name) { |n| "fruit#{n}" }
    # name { "test" }
    description { 'この果物は美味しい' }
  end
end
