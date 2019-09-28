class MembershipPolicy < ApplicationPolicy
  def create?
    user.plan.pro?
  end

  def new?
    # Check if this user is an admin of the removed
    # memberships project
    create? && record.project
                 .memberships
                 .admin
                 .find_by(user: user)
  end

  def destroy?
    create?
  end

  class Scope < Scope
    def resolve
      projects = Project.joins(:memberships).where(memberships: { user: user , role: Membership.roles[:admin] })
      scope.where.not(user: user).where(project: projects)
    end
  end
end
