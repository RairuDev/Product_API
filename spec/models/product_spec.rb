require "rails_helper"

RSpec.describe Product, type: :model do
  let (:category) { create(:category) }
  let (:product) { create(:product) }
  describe "会員登録" do
    it "全ての項目が存在すれば登録できること" do
      expect(product).to be_valid
    end
  end

  describe "項目にNilが入ってる時" do
    context "category_idがnilな時" do
      it "登録できないこと" do
        product = build(:product, category_id: nil)
        product.valid?
        expect(product.errors[:category_id]).to include ("can't be blank")
      end
    end

    context "nameがnilな時" do
      it "登録できないこと" do
        product = build(:product, name: nil)
        product.valid?
        expect(product.errors[:name]).to include ("can't be blank")
      end
    end

    context "descriptionがnilな時" do
      it "登録できないこと" do
        product = build(:product, description: nil)
        product.valid?
        expect(product.errors[:description]).to include ("can't be blank")
      end
    end
  end

  describe "name一意性のテスト" do
    context "登録したnameが存在する場合" do
      it "登録できないこと" do
        binding.pry
        product = build(:product, name: product.name)
        product.valid?
        expect(product.errors[:name]).to include ("has already been taken")
      end
    end
  end
end
