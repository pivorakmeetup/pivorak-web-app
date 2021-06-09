# frozen_string_literal: true

FactoryBot.define do
  factory :order_item, class: Shop::OrderItem do
    price { 12 }
  end
end
