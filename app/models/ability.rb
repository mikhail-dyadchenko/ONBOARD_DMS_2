class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, Card
    can :read, Comment

    return unless user.present?
    can :manage, Card, user: user
    can :manage, Comment, user: user
    can :manage, Profile, user: user

    return unless user.admin?
    can :manage, :all
  end
end
