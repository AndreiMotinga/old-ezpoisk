class Ability
  include CanCan::Ability

  def initialize(user)
    if user && user.admin?
      can :access, :rails_admin   # grant access to rails_admin
      can :dashboard
      can :read, :all
      can :manage, second_level_models

      if user.role? :superadmin # Andrei
        can :manage, :all
      end
    end


    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end

  private

  def second_level_models
    [
      Forem::Category, Forem::Forum, Forem::Group, Forem::Membership,
      Forem::ModeratorGroup, Forem::Post, Forem::Subscription,
      Forem::Topic, Forem::View,
      Post, Comment, Feedback
    ]
  end

end
