class CategoryPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      if user.admin? || user.has_role?(:moderator) # aula 15 1:17 mim
        scope.all
      else
        raise Pundit::NotAuthorizedError
      end
    end
  end

  def create?
    #user&.admin? # aula 15 - 45 min
    user.admin? || user.has_role?(:moderator)
  end

  def index?
    user&.admin? || user&.has_role?(:moderator)
  end

  def update?
    user.admin? || user.has_role?(:moderator)
  end

  def destroy?
    user.admin?
  end
end
