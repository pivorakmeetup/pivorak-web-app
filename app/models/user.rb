class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,
         :validatable, :omniauthable, omniauth_providers: Devise.omniauth_providers

  has_many :identities, dependent: :destroy
  has_many :donations,  dependent: :destroy

  def full_name
    first_name + ' ' + last_name
  end
end
