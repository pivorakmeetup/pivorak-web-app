# frozen_string_literal: true

require 'modules/searchable/configuration/shared_group'

RSpec.describe ::Searchable::Configuration::User do
  it_behaves_like 'Configurable'
end
