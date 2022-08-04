module Api
  module V1
    class Api::V1::ProductsController < ApplicationController
      before_action :set_product, only: [:show, :update, :destroy]

      def index
        products = Product.order(created_at: :desc)
        render json: { status: "SUCCESS", message: "値を全て取得しました", data: products }
      end

      def show
        render json: { status: "SUCCESS", message: "特定の値を取得しました", data: @product }
      end

      def create
        product = Product.new(product_params)
        if product.save
          render json: { status: 201, data: product }
        else
          render json: { status: 422, data: product }
        end
      end

      def destroy
        @product.destroy
        render json: { status: "SUCCESS", message: "DELETE the Product", data: @product }
      end

      def update
        if @product.update(product_params)
          render json: { status: "SUCCESS", message: "Update the Product", data: @product }
        else
          render json: { status: "SUCCESS", message: "NOT Update", data: @product.errors }
        end
      end

      private

      def set_product
        @product = Product.find(params[:id])
      end

      def product_params
        params.require(:product).permit(:)
      end
    end
  end
end
