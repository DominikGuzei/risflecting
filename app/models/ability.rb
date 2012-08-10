class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.has_role? :admin
      can :manage, :all
    elsif user.has_role? :member
      can :manage, :all

      cannot [:create, :update, :destroy], Appointment
      cannot :create, User
    end
  end
end