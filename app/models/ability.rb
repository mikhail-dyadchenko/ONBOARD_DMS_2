class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new(role: "guest")

    case user.role
    when "admin"
      admin_abilities(user)
    when "user"
      user_abilities(user)
    else
      guest_abilities(user)
    end
  end

  private

  def admin_abilities(user)
    can :manage, :all
    can :change_contributor_status, User, role: "user"
    can :change_contributor_status, User, role: "guest"
  end

  def user_abilities(user)
    can :manage, User, id: user.id
    can :create, Card
    can :read, Card
    can [ :update, :destroy ], Card, user_id: user.id
    can :create, Comment
    can :read, Comment
    can [ :update, :destroy ], Comment, user_id: user.id
  end

  def guest_abilities(user)
    can :read, Card
    can :read, Comment
    can :create, User
  end
end
