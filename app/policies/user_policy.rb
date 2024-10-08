class UserPolicy < ApplicationPolicy
  # NOTE: Up to Pundit v2.3.1, the inheritance was declared as
  # `Scope < Scope` rather than `Scope < ApplicationPolicy::Scope`.
  # In most cases the behavior will be identical, but if updating existing
  # code, beware of possible changes to the ancestors:
  # https://gist.github.com/Burgestrand/4b4bc22f31c8a95c425fc0e30d7ef1f5
  def show?
    true
  end

  def edit?
    true
  end

  class Scope < ApplicationPolicy::Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      blocked_user_ids = User.joins(:blocks_as_blocker)
                             .where(blocks: { blocked_id: user.id })
                             .select(:id)
      scope.where.not(id: user.id)
           .where.not(id: blocked_user_ids)
    end
  end
end
