class Admin::InstrumentPolicy < ApplicationPolicy
  attr_reader :current_user, :model

  def initialize(current_user, model)
    @current_user = current_user
    @current_role = current_user.role
    @author = model.created_by
    @instrument = model
  end

  def approve?
    @current_user and @current_user.approver?
    @instrument.submitted?
  end
end