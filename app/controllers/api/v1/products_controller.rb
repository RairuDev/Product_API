module Api
  module V1
    class Api::V1::ProductsController < ApplicationController
      # before_action :set_product, only: [:update, :destroy]

      def index
        # binding.pry
        if params[:category_id] && Category.find_by(id: params[:category_id])
          products = Product.where(category_id: params[:category_id].to_i)
          test = [category_name: Category.find_by(id: params[:category_id]).category_name]
          products.merge(test)
          # Product.where(category_id: 1).joins(:categories).merge(Category.where(category_name: "PC"))
          render json: { status: "SUCCESS", message: "指定されたcategory_idの値を取得しました", data: products }
        elsif params[:category_id]
          render json: { status: "Category Not Found", message: "指定されたカテゴリーはありませんでした" }
        else
          # binding.pry
          products = Product.all
          render json: { status: "SUCCESS", message: "パラメータが指定されなかったので全て返します", data: products }
        end
      end

      def show
        # binding.pry
        product = Product.find(params[:id])
        render json: { status: 200, message: "特定の値を取得しました", data: product }
      end

      def create
        product = Product.new(product_params)
        if product.save
          render json: { status: 201, message: "productを新しく作成しました", data: product }
        else
          render json: { status: 422, message: "productの作成に失敗しました", data: product }
        end
      end

      def destroy
        product = Product.find(params[:id])
        product.destroy
        render json: { status: "SUCCESS", message: "DELETE the Product", data: product }
      end

      def update
        product = Product.find(params[:id])
        if product.update(product_params)
          render json: { status: "SUCCESS", message: "Update the Product", data: product }
        else
          render json: { status: "SUCCESS", message: "NOT Update", data: product.errors }
        end
      end

      private

      def product_params
        params.require(:product).permit(:name, :description, :category_id)
      end
    end
  end
end
