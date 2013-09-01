class BackendAbility
  include CanCan::Ability
  def initialize(user)
    user ||= User.new # guest user (not logged in)

    if user.role? :admin
      can :manage, :all
    elsif user.role? :user
      cannot :read, :all
    end
  end
end