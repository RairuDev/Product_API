# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Products", type: :request do
  describe "ProductAPI(index)" do
    it "全ての商品を取得する" do
      FactoryBot.create_list(:product, 10)
      get "/api/v1/products"
      json = JSON.parse(response.body)
      # リクエスト成功を表す200が返ってきたか確認する。
      expect(response.status).to eq(200)
      expect(json["message"]).to eq("パラメータが指定されなかったので全て返します")
      # 正しい数のデータが返されたか確認する。
      expect(json["data"].length).to eq(10)
    end

    it "category_idを指定したらその商品を取得する" do
      product = create(:product)
      get "/api/v1/products?category_id=#{product.category_id}"
      json = JSON.parse(response.body)
      expect(response.status).to eq(200)
      expect(json["message"]).to eq("指定されたcategory_idの値を取得しました")
      expect(json["data"][0]["category_id"]).to eq(product.category_id)
    end

    it "登録されてないcategory_idを指定したら失敗する" do
      product = create(:product)
      get "/api/v1/products?category_id=2"
      json = JSON.parse(response.body)
      expect(response.status).to eq(200)
      expect(json["message"]).to eq("指定されたカテゴリーはありませんでした")
    end
  end

  describe "ProductAPI(show)" do
    it "特定のproductを取得する" do
      product = create(:product)
      get "/api/v1/products/#{product.id}"
      json = JSON.parse(response.body)
      expect(response.status).to eq(200)
      expect(json["message"]).to eq("特定の値を取得しました")
      expect(json["data"]["category_id"]).to eq(product.category_id)
    end
  end

  describe "ProductAPI(create)" do
    context "正しい値を渡したときに" do
      it "新しいproductを作成する" do
        category = create(:category) # これがないとリレーション関係でうまくいかない
        valid_params = { category_id: 1, name: "バナナ", description: "朝食べると元気が出る" }
        # データが作成されている事を確認
        expect { post "/api/v1/products", params: { product: valid_params } }.to change(Product, :count).by(+1)
        # リクエスト成功を表す200が返ってきたか確認する。
        json = JSON.parse(response.body)
        expect(response.status).to eq(200)
        expect(json["message"]).to eq("productを新しく作成しました")
      end
    end

    context "渡す値が適切じゃない時" do
      it "新しいproductの作成に失敗する" do
        category = create(:category) # これがないとリレーション関係でうまくいかない
        valid_params = { category_id: 2, name: "バナナ", description: "朝食べると元気が出る" }
        # データが作成されている事を確認
        expect { post "/api/v1/products", params: { product: valid_params } }.to change(Product, :count).by(0)
        # リクエスト成功を表す200が返ってきたか確認する。
        json = JSON.parse(response.body)
        expect(response.status).to eq(200)
        expect(json["message"]).to eq("productの作成に失敗しました")
      end
    end
  end

  describe "ProductAPI(update)" do
    it "productの更新を行う" do
      product = create(:product, name: "old-name")
      put "/api/v1/products/#{product.id}", params: { product: { name: "new-name" } }
      json = JSON.parse(response.body)
      # リクエスト成功を表す200が返ってきたか確認する。
      expect(response.status).to eq(200)
      expect(json["message"]).to eq("Update the Product")
      # データが更新されている事を確認
      expect(json["data"]["name"]).to eq("new-name")
    end
  end

  describe "ProductAPI(destroy)" do
    it "productを削除する" do
      product = create(:product)
      # データが削除されている事を確認
      expect { delete "/api/v1/products/#{product.id}" }.to change(Product, :count).by(-1)
      # リクエスト成功を表す200が返ってきたか確認する。
      expect(response.status).to eq(200)
      json = JSON.parse(response.body)
      expect(json["message"]).to eq("DELETE the Product")
    end
  end
end
