# frozen_string_literal: true

Rails.application.routes.draw do
  mount Shop::Engine => '/shop'
end
