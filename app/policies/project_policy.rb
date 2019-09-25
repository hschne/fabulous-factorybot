class ProjectPolicy < ApplicationPolicy
  def show?
    Membership.find_by(user: user, project: record)
  end

  def create?
    user
  end

  def new?
    create?
  end

  def update?
    Membership.where(role: 'admin')
      .find_by(user: user, project: record)
  end

  def edit?
    update?
  end

  def destroy?
    update?
  end

  class Scope < Scope
    def resolve
      scope.joins(:membership).where(user: user)
    end
  end

end
