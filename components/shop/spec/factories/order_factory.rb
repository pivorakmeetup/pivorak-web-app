# frozen_string_literal: true

FactoryBot.define do
  factory :order, class: Shop::Order do
    shipment_address { 'Lviv, Pivorak street' }
  end
end
