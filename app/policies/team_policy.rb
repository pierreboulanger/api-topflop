class TeamPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end

    def create?
      return true
    end
  end
end
