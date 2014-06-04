class FirmPolicy < ApplicationPolicy

  class Scope < Struct.new(:user, :scope)
    def resolve
      scope
    end
  end

  def show?
    record.user_id == user.id
  end

  def update?
    record.user_id == user.id
  end

  def destroy?
    record.user_id == user.id
  end

  def ownership?
    record.user_id == user.id
  end

  def cap_table?
    record.user_id == user.id
  end

end
