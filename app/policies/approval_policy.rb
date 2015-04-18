class ApprovalPolicy < ApplicationPolicy
  attr_reader :current_user, :model

  def initialize(current_user, model)
    @current_user = current_user
    @current_role = current_user ? current_user.role : 'visitor'
    @author = model.approvable.submitted_by
    @approval = model
  end

  def submit?
    return false unless @approval.new_record? or @approval.approval_status == 'incompleted' 
    @current_user and @current_user == @author
  end

  def approve?
    return false unless @approval.submitted?
    @current_user and @current_user.approver?
  end

end