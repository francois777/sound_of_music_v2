class Admin::UserPolicy < ApplicationPolicy
  attr_reader :current_user, :model

  def initialize(current_user, model)
    @current_user = current_user
    @user = model
  end

  def index?
    return true if current_user.admin?
    ['owner', 'approver'].include? current_user.role
  end

end
