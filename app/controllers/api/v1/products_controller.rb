# frozen_string_literal: true
module Api
  module V1
    class ProductsController < ApplicationController
      before_action :set_product, only: [:show, :update, :destroy]

      def index
        products = if params[:category_id] && Category.find(params[:category_id])
            Product.joins(:category).select("products.id, products.category_id, categories.name AS category_name, products.name, products.description, products.created_at").where(category_id: params[:category_id])
          else
            Product.joins(:category).select("products.id, products.category_id, categories.name AS category_name, products.name, products.description, products.created_at")
          end
        render json: { data: products }, status: :ok
      end

      def show
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
        product.destroy
        render json: { status: "SUCCESS", message: "DELETE the Product", data: product }
      end

      def update
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

      def set_product
        product = Product.find(params[:id])
      end
    end
  end
end
