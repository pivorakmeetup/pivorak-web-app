class User < ApplicationRecord
  LATIN_LETTERS_REGEX = /[a-zA-Z]+/

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,
         :validatable, :omniauthable, omniauth_providers: Devise.omniauth_providers

  has_many :identities, dependent: :destroy
  has_many :donations,  dependent: :destroy

  validates :first_name, :last_name, presence: true
  validates :first_name, :last_name, format: { with: LATIN_LETTERS_REGEX,  message: I18n.t('errors.only_latin_letters') }

  def full_name
    "#{first_name} #{last_name}"
  end
end
