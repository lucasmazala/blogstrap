class CommentPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end
  def create? #aula 19 43 min
    user&.id
  end

  def destroy?
    user&.id == record.user.id # executa se o usuário logado for o mesmo usuário do comentário 
  end
end
