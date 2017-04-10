module Profiling
  class User < ApplicationRecord
    self.table_name = :profiling_users

    extend FriendlyId
    friendly_id :full_name, use: :slugged

    LATIN_LETTERS_REGEX = /[a-zA-Z]+/

    mount_uploader :cover, SpeakerCoverUploader

    has_many :visit_requests, foreign_key: :user_id, primary_key: :user_id, dependent: :destroy

    scope :sorted,    -> { order(:last_name).order(:first_name) }

    validates :first_name, :last_name, :email, :slug, presence: true
    validates :first_name, :last_name, format: {
      with: LATIN_LETTERS_REGEX,  message: I18n.t('errors.only_latin_letters')
    }

    def full_name
      "#{first_name} #{last_name}"
    end

    def reverse_full_name
      "#{last_name} #{first_name}"
    end

    def should_generate_new_friendly_id?
      slug.blank? || first_name_changed? || last_name_changed?
    end

    def normalize_friendly_id(string)
      count = User.where(first_name: first_name, last_name: last_name).count

      count > 0 ? super + '-' + (count + 1).to_s : super
    end
  end
end
