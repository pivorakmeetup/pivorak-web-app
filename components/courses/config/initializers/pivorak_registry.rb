unless Rails.env.test?
  # Register as admin navigation menu link
  require 'ez/items/link'

  Ez::Registry.in(:admin_primary_navigation, by: Courses::Engine) do |registry|
    registry.add Ez::Items::Link.new('courses.plural', '/admin/courses')
  end
end
