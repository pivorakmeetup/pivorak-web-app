require 'dry_helpers/model'

class Group < ApplicationRecord
  RESOURCES = [ Talk ] # add groupable model here please...

  # define socopes for each resource
  RESOURCES.each do |resource|
    scope    resource_to_many(resource), -> { where(resource: resource.to_s ) }
    has_many resource_to_many(resource), dependent: :nullify
  end

  validates :name, :resource, presence: true
end
