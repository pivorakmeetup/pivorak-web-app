module Authentication
  class User < ApplicationRecord
    self.table_name = :authentication_users

    include ::Searchable

    devise :database_authenticatable, :registerable, :confirmable,
           :recoverable, :rememberable, :trackable,
           :validatable, :omniauthable, omniauth_providers: Devise.omniauth_providers

    has_many :identities,                      dependent: :destroy
    has_many :donations,                       dependent: :destroy
    has_many :talks, foreign_key: :speaker_id, dependent: :nullify

    # for sending emails in background
    def send_devise_notification(notification, *args)
      devise_mailer.send(notification, self, *args).deliver_later
    end
  end
end
