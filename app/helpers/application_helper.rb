module ApplicationHelper
  def admin?
    current_user&.admin?
  end
end
