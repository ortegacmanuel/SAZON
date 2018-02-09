class Ability
  include CanCan::Ability

  def initialize(user)

    alias_action(:read, :create, :update, :to => :access_but_not_delete)

    # See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilities

    user ||= User.new # guest user

    # use this if you get stuck:
    # if user.id == 1 #quick hack
    #   can :access, :all
    if user.role? :superadmin
      can :manage, :all
    elsif user.role? :admin
        can :access_but_not_delete, :all
        can :view, Document
        can :destroy, [Begrip, Assignment, Image]
    elsif user.role? :student
      can :read, [Document, Assignment, Begrip]
      cannot [:create, :update, :delete, :index], :all
      can :view, Document
    end
  end
end
