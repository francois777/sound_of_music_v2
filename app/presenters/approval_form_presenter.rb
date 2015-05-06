class ApprovalFormPresenter
  include ApplicationHelper

  attr_reader :approval

  def initialize(approval)
    @approval = approval
  end

  def approver_name(resource)
    resource.approval.approver.name
  end

  def status(resource)
    resource.approval_status_display
  end

end