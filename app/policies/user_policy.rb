class UserPolicy < ApplicationPolicy
  attr_reader :current_user, :model

  def initialize(current_user, model)
    @current_user = current_user
    @user = model
  end

  def show?
    return true if @user == current_user or current_user.admin?
    ['owner', 'approver'].include? current_user
  end

  def index?
    # Important note: This method is used by _navigation_links!
    return false unless current_user
    return true if current_user.admin?
    ['owner', 'approver'].include? current_user.role
  end

  def approver?
    current_user and current_user.approver?
  end  

end
