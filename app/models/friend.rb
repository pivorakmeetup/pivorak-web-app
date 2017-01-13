class Friend < ApplicationRecord
  mount_uploader :logo, DefaultImageUploader

  belongs_to :group

  validates :name, presence: true
end
