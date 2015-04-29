class ContributionTypePolicy < ApplicationPolicy
  attr_reader :current_user, :model

  def initialize(current_user, model)
    @current_user = current_user
    @current_role = current_user ? current_user.role : 'visitor'
    @artist = model
  end

  def new?
    return false unless @current_user 
    @current_user.admin? or @current_user.owner?
  end

  def show?
    @current_user.admin? or @current_user.owner?
  end

  def index?
    true
  end

  def edit?
    return false unless @current_user 
    @current_user.admin? or @current_user.owner?
  end

  def update?
    return false unless @current_user 
    @current_user.admin? or @current_user.owner?
  end

  def contribution_type_not_authorized
    flash[:alert] = "This operation is not allowed on contribution types."
    redirect_to (request.referrer or contribution_types_path)
  end

end