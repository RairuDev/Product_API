require "rails_helper"

RSpec.describe Product, type: :model do
  context "全ての項目が適切な時" do
    it "保存される" do
      product = create(:product)
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
        # binding.pry
        product = build(:product, name: nil, category_id: 1)
        product.valid?
        expect(product.errors[:name]).to include ("can't be blank")
      end
    end

    context "descriptionがnilな時" do
      it "登録できないこと" do
        product = build(:product, description: nil, category_id: 1)
        product.valid?
        expect(product.errors[:description]).to include ("can't be blank")
      end
    end
    context "登録したnameが存在する場合" do
      it "登録できないこと" do
        # binding.pry
        product = create(:product)
        new_product = build(:product, name: product.name)
        new_product.valid?
        expect(new_product.errors[:name]).to include ("has already been taken")
      end
    end
  end
end
