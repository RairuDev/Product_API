# frozen_string_literal: true

# == Schema Information
#
# Table name: categories
#
#  id            :integer          not null, primary key
#  category_name :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
require 'rails_helper'

RSpec.describe Category, type: :model do
  let(:category) { create(:category) }
  context '全ての項目が適切な時' do
    it '保存される' do
      # binding.pry
      expect(category).to be_valid
    end
  end
  context '項目にNilが入ってる時' do
    it '保存されないこと' do
      category = build(:category, category_name: nil)
      category.valid?
      expect(category.errors[:category_name]).to include("can't be blank")
    end
  end
end
