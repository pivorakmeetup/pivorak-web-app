unless Rails.env.test?
  # Register as admin navigation menu link
  require 'ez/items/link'

  Ez::Registry.in(:admin_primary_navigation, by: Bb::Engine) do |registry|
    registry.add Ez::Items::Link.new('bb.home.plural', '/admin/bb', item: :bb)
  end
end
