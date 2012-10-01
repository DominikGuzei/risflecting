class Ability
  include CanCan::Ability

  def initialize user
    user ||= User.new
    send user.role.name.downcase.to_sym

    cannot :add_attachment, [Question, Project]
    can :add_attachment, [Question, Project], :user_id => user.id

    cannot :edit, User
    can :edit, User, :id => user.id

    cannot :edit, Question
    can :edit, Question, :user_id => user.id
  end

  def admin
    can :manage, :all
  end

  def coordinator
    admin
    cannot [:create, :update, :destroy], Appointment
    cannot :create, User
  end

  def member
    coordinator
    cannot [:create, :destroy], Document
  end
end
