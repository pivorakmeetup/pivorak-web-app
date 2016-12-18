class User < ApplicationRecord
  extend FriendlyId
  friendly_id :full_name, use: :slugged

  LATIN_LETTERS_REGEX = /[a-zA-Z]+/

  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable,
         :validatable, :omniauthable, omniauth_providers: Devise.omniauth_providers

  has_many :identities, dependent: :destroy
  has_many :donations,  dependent: :destroy

  validates :first_name, :last_name, :slug, presence: true
  validates :first_name, :last_name, format: { with: LATIN_LETTERS_REGEX,  message: I18n.t('errors.only_latin_letters') }

  def full_name
    "#{first_name} #{last_name}"
  end

  def should_generate_new_friendly_id?
    slug.blank? || first_name_changed? || last_name_changed?
  end

  def normalize_friendly_id(string)
    count = User.where(first_name: first_name, last_name: last_name).count
    if count > 0
      super + "-" + (count + 1).to_s
    else
      super
    end
  end

end
