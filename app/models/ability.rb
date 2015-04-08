class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    alias_action :create, :read, :update, :destroy, :to => :crud

    if user.has_role? :admin
      can :manage, :all
    else
      can :crud, User, :id => user.id
      can :crud, Favorite, :user_id => user.id
      can :crud, Business, :user_id => user.id
      can :crud, Location, :business => { :user_id => user.id }
      can :crud, Deal, :business => { :user_id => user.id }
      can :crud, Payment, :business => { :user_id => user.id }
    end
  end
end
