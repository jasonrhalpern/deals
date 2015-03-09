class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    alias_action :create, :read, :update, :destroy, :to => :crud

    if user.has_role? :admin
      can :manage, :all
    else
      can :crud, User, :id => user.id
    end
  end
end
