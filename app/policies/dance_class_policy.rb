class DanceClassPolicy < ApplicationPolicy
  def index?
    user_renewal_date_is_in_future? && user_is_a_teacher?
  end
end
