class Friend < ApplicationRecord
  include ::Searchable
  include Publishable

  mount_uploader :logo, DefaultImageUploader

  belongs_to :group

  validates :name, presence: true
end
