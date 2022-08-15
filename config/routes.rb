# frozen_string_literal: true

# == Route Map
#

Rails.application.routes.draw do
  namespace 'api' do
    namespace 'v1' do
      resources :products
    end
  end
end
