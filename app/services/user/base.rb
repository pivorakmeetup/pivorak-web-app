class User
  class Base < ApplicationService
    PERMITTED_KEYS = %i[
      cover
      email
      first_name last_name
      password password_confirmation
      synthetic
    ]

    def initialize(user, params = {}, options = {})
      @user                  = user
      @password              = params[:password]
      @password_confirmation = params[:password_confirmation]
      @email                 = params[:email]
      @cover                 = params[:cover]
      @first_name            = params[:first_name]
      @last_name             = params[:last_name]
      @options               = options
    end

    private

    attr_reader *PERMITTED_KEYS
    attr_reader :user, :options

    def user_params
      PERMITTED_KEYS.inject({}) { |mem, key| mem.merge!(key => send(key)) }
    end
  end
end
