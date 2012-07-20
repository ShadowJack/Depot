class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.role? :admin
      can :manage, :all
    elsif user.role? :seller
      can :manage, [Product, Order]
    elsif user.role? :buyer
      can :read, [Product, Cart, Order, LineItem]
    end
    
    
  end
end
