class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,
         :validatable, :omniauthable, omniauth_providers: Devise.omniauth_providers

  has_many :identities, dependent: :destroy

  validates :email, presence: true
end
