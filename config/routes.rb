Rails.application.routes.draw do
  namespace "api" do
    namespace "V1" do
      resources :products
    end
  end
end
