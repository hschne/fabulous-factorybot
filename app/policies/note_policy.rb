class NotePolicy < ApplicationPolicy
  def show?
    Membership.find_by(user: user, project: record.project)
  end

  def new?
    update?
  end

  def update?
    membership = Membership.admin
      .or(Membership.writer)
      .find_by(user: user, project: record.project)
  end

  def edit?
    update?
  end

  def create?
    update?
  end

  def destroy?
    update?
  end

  class Scope < Scope
    def resolve
      scope.joins(project: :memberships).where(project: { memberships: { user: user } })
    end
  end
end
