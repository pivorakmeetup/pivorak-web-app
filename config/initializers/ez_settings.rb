Ez::Settings.config.base_controller = 'Admin::BaseController'

app = Ez::Settings::Interface.define(:app) do
  group :general do
    key :app_title, default: -> { '#pivorak Lviv Ruby User Group' }
  end

  group :admin do
    key :app_title, default: -> { 'Admin PivorakWebApp' }
  end

  group :events do
    key :default_limit,             type: :integer, default: -> { 50 }
    key :default_limit_verified,    type: :integer, default: -> { 35 }
    key :default_started_at_hours,  type: :integer, default: -> { 18 }
    key :default_finished_at_hours, type: :integer, default: -> { 22 }
  end

  # This is dummy settings group just to show the power of ez-settings
  group :showcase do
    key :string,                        default: -> { 'string' }
    key :bool,         type: :boolean,  default: -> { true }
    key :integer,      type: :integer,  default: -> { 777 }
    key :select,       type: :select,   default: -> { 'foo' }, collection: %w(foo bar baz)
    key :not_validate, required: false, presence: false
    key :not_for_ui,   required: false, ui:       false
  end
end

app.configure do |config|
  config.backend         = Ez::Settings::Backend::FileSystem.new(Rails.root.join('config', 'settings.yml'))
  config.default_path    = '/admin/settings'
  config.custom_css_map  = {
    nav_label:                           'ui large header',
    nav_menu:                            'ui secondary menu',
    nav_menu_item:                       'item',
    overview_page_wrapper:               'ui stackable one column grid',
    overview_page_section:               'column',
    overview_page_section_header:        'ui medium header',
    overview_page_section_content:       'ui internally celled grid',
    overview_page_section_content_key:   'four wide column',
    overview_page_section_content_value: 'four wide column',
    group_page_wrapper:                  'ui stackable one column grid',
    group_page_inner_wrapper:            'six wide column',
    group_page_header:                   'ui medium header',
    group_page_form_boolean_wrapper:     'ui slider checkbox',
    group_page_actions_save_button:      nil,
    group_page_actions_cancel_link:      nil
  }
  config.dynamic_css_map = {
    nav_menu_item: {
      css_class: 'active',
      if: ->(controller, path_fragment) { controller.request.path.end_with?(path_fragment.to_s) }
    }
  }
end

# Register as an settings interface
Ez::Registry.in(:settings_interfaces, by: PivorakWebApp) do |registry|
  registry.add app
end

# Register as admin navigation menu link
require 'ez/items/link'

Ez::Registry.in(:admin_primary_navigation, by: Ez::Settings::Engine) do |registry|
  registry.add Ez::Items::Link.new('settings.plural', '/admin/settings')
end
