class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    
    # TODO: Fjernes
    #can :manage, :all

    if user.role? :admin
      can :manage, :all
    end
  end
end
