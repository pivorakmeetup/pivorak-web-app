# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :shop do
    resources :items, only: %i[index]
    resources :order_items, only: %i[index create update destroy]
    resources :checkouts, path: :checkout, only: %i[index]
  end

  namespace :admin do
    namespace :shop do
      resources :items, only: %i[index show new edit create update]
    end
  end
end
