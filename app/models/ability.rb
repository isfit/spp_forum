class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    
    can :manage, :all
    if user.role? :admin
      can :manage, :all
    elsif user.role? :normal
      can :read, :all
      can :create, Article
      can :update, Article, :user_id => user.id
      can :create, ForumThread
      can :create, ForumPost
      can :update, ForumPost, :user_id => user.id
      can :update, ForumThread, :user_id => user.id
      can :update, User, :id => user.id
    end
  end
end
