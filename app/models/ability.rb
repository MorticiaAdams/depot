class Ability
  include CanCan::Ability

  def initialize(user)
      # See the wiki for details:
      # https://github.com/ryanb/cancan/wiki/Defining-Abilities
      user ||= User.new                     # guest user (not logged in)
      user.assign_role if !user.role_id     # assgin a role to the guest user

      if user.admin?
          can :manage, :all
      else
          can :manage, :AdminController
          can [:read, :update], LoginController
          can [:read], StoreController
          can [:read, :create, :update], Order
          can :manage, Cart
          can [:read, :create, :update], LineItem
          can [:read], Product
          can :create, SessionsController do |session|
              session.try(:user) == user
          end
          can :destroy, SessionsController do |session|
              session.try(:user) == user
          end
      end
  end

end
