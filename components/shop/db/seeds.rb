# frozen_string_literal: true

#=== Shop Items =========================================================================

puts ::Shop::Item.where(name: 'Pivorak Socks').first_or_create!(
  description: 'Test description', price: 12, available_qty: 5
)
