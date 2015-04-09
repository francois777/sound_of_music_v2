class Admin::InstrumentPolicy < ApplicationPolicy
  attr_reader :current_user, :model

  def initialize(current_user, model)
    @current_user = current_user
    @current_role = current_user.role
    @author = model.created_by
    @instrument = model
  end

  def approve?
    puts "Executing admin instrument policy"
    @instrument.submitted? and @current_user and @current_user.approver?
  end
end