# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :shop do
    resources :items
  end

  namespace :admin do
    namespace :shop do
      resources :items
    end
  end
end
