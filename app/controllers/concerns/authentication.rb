module Authentication
  extend ActiveSupport::Concern

  included do
    helper_method :current_academic
  end

  def current_academic
    return current_user if current_user.present?
    NullAcademic.new
  end
end
