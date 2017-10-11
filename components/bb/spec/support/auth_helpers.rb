module AuthHelpers
  attr_reader :current_user

  def assume_logged_in_user(user = nil)
    @current_user = user || create(:user)

    allow_any_instance_of(ApplicationController)
      .to receive(:current_user).and_return(current_user)
  end
end
