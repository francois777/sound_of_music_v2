class ApprovalPolicy < ApplicationPolicy
  attr_reader :current_user, :model

  def initialize(current_user, model)
    @current_user = current_user
    @current_role = current_user ? current_user.role : 'visitor'
    if model.approvable.class.name == 'Instrument'
      @author = model.approvable.created_by
    else  
      @author = model.approvable.submitted_by
    end  
    @approval = model
  end

  def edit?
    return false unless @current_user and (@current_user == @author or @current_user.approver?)
    return true if @current_user.approver? and ['submitted', 'approved'].include? @approval.approval_status
    ['incomplete', 'approved', 'to_be_revised'].include? @approval.approval_status
  end

  def submit?
    return false unless @current_user and @current_user == @author
    ['incomplete', 'to_be_revised'].include? @approval.approval_status
  end

  def approve?
    return false unless @approval.submitted? or @approval.to_be_revised?
    @current_user and @current_user.approver?
  end

end