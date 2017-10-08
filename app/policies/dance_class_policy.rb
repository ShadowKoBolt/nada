class DanceClassPolicy < ApplicationPolicy
  def teacher?
    @user.teacher?
  end

  alias index? teacher?
  alias new? teacher?
  alias edit? teacher?
  alias create? teacher?
  alias update? teacher?
  alias destroy? teacher?
end
