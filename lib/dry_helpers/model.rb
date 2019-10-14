# frozen_string_literal: true

def resource_to_many(resource)
  resource.to_s.underscore.pluralize.to_sym
end
