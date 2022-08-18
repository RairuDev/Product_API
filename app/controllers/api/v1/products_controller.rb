# frozen_string_literal: true
module Api
  module V1
    class ProductsController < ApplicationController
      def index
        if params[:category_id] && Category.find(params[:category_id])
          products = Product.joins(:category).select("products.id, products.category_id, categories.name AS category_name, products.name, products.description, products.created_at").where(category_id: params[:category_id])
          render json: { status: "SUCCESS", message: "指定されたcategory_idの値を取得しました", data: products }
        else
          products = Product.joins(:category).select("products.id, products.category_id, categories.name AS category_name, products.name, products.description, products.created_at")
          render json: { message: "パラメータが指定されなかったので全て返します", data: products }, status: :ok
        end
      end

      def show
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
