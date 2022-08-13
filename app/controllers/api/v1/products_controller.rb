module Api
  module V1
    class Api::V1::ProductsController < ApplicationController
      # before_action :set_product, only: [:update, :destroy]

      def index
        binding.pry
        if Category.find(params[:category_id])
          product = Product.where(category_id: params[:category_id].to_i)
          render json: { status: "SUCCESS", message: "特定の値を取得しました", data: product }
        elsif Category.find(params[:category_id]) == false
          render json: { status: 422, message: "指定されたカテゴリーはありませんでした", data: product }
        else
          binding.pry
          product = Product.all
          render json: { status: "SUCCESS", message: "全て返します", data: product }
        end
        # render json: { status: "SUCCESS", message: "値を全て取得しました", data: products }
      end

      def show
        # binding.pry
        product = Product.find(params[:id])
        render json: { status: "SUCCESS", message: "特定の値を取得しました", data: product }
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

      #指定されたカテゴリーIDが存在するのかをチェックする
      # def category_check
      #   binding.pry
      #   if Category.find(params[:category_id])
      #     Product.where(category_id: params[:category_id].to_i)
      #   end
      # end

      def product_params
        params.require(:product).permit(:name, :description, :category_id)
      end
    end
  end
end
