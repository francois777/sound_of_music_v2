class ApprovalsController < ApplicationController

  before_filter :authenticate_user!
  before_action :set_approval

  def submit
    process_submittal
    redirect_to [@approval.approvable]
  end

  def approve
    params[:commit] == "Approve" ? process_approval : process_rejection
    redirect_to [@approval.approvable]
  end

  private

    def set_approval
      @approval = Approval.find(params['approval']['approval_id'].to_i)
      @subject_name = @approval.approvable.class.name
    end

    def process_submittal
      @approval.rejection_reason = :not_rejected
      @approval.approval_status = :submitted
      @approval.save
      #flash[:notice] = "t(:#{@subject_name}_submitted, scope: [:success])"
      flash[:notice] = "#{@subject_name} has been submitted."
    end

    def process_approval
      @approval.approver = current_user
      @approval.approval_status = :approved
      @approval.save
      #flash[:notice] = "t(:#{@subject_name}_approved, scope: [:success])"
      flash[:notice] = "#{@subject_name} has been approved."
    end

    def process_rejection
      @approval.approver = current_user
      @approval.approval_status = :to_be_revised
      @approval.rejection_reason = params["approval"]["rejection_reason"].to_i

      if @approval.save
        #flash[:notice] = "t(:#{@subject_name}_to_be_revised, scope: [:success])"
        flash[:notice] = 'The author is requested to revise this article.'
      else
        puts @approval.errors.inspect
        #flash[:error] = "t(:#{@subject_name}_not_approved, scope: [:failure])"
        flash[:error] = "Unexpected error; A revision for #{@subject_name} has not been processed"
      end
    end

end  