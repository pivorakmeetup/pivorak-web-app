# All apps always require possibility to group some resources.
# Types, kinds, under_types.
# I want to avoid creating such subresources like `TalkType` or `SomeOtherGroup`.
# Better to keep one polymorphic model - `Group`.
# Just add new resource to it's `RESOURCES` constant and enjoy the life.
require 'dry_helpers/model'

class Group < ApplicationRecord
  RESOURCES = [ Talk, Friend ] # add groupable model here please...

  # define socopes for each resource
  RESOURCES.each do |resource|
    scope    resource_to_many(resource), -> { where(resource: resource.to_s ) }
    has_many resource_to_many(resource), dependent: :nullify
  end

  validates :name, :resource, presence: true
end
