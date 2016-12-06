class User
  class Update
    PERMITTED_KEYS = %i[first_name last_name email password password_confirmation]

    def initialize(params)
      @user = params[:user]
      @password = params[:password]
      @password_confirmation = params[:password_confirmation]
      @email = params[:email]
      @first_name = params[:first_name]
      @last_name = params[:last_name]
    end

    def call
      if password.blank? && password_confirmation.blank?
        user.update_without_password(user_params)
      else
        user.update(user_params)
      end
    end

    private

    attr_reader *PERMITTED_KEYS
    attr_reader :user

    def user_params
      params = {}
      PERMITTED_KEYS.each do |key|
        params[key] = send(key)
      end
      params
    end
  end
end
