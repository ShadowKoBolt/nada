class AdminPolicy < ApplicationPolicy
  def show?
    @user && @user.admin?
  end
end
