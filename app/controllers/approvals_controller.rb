class ApprovalsController < ApplicationController

  before_filter :authenticate_user!
  before_action :set_approval

  def submit
    @approval.submitted!
    flash[:notice] = "#{@subject} has been submitted"
    redirect_to [@subject]
  end

  def approve
    puts "Params: #{params.inspect}"
    #  Parameters: {"utf8"=>"✓", "authenticity_token"=>"H7...0Rg==", 
    #  "approval"=>{"rejection_reason"=>"1"}, "commit"=>"Request revision", "id"=>"1"}
    params[:commit] == "Approve" ? process_approval : process_rejection
    redirect_to [@subject]
  end

  private

    def set_approval
      @approval = Approval.find(params[:id])
      @subject = @approval.approvable.class.downcase
    end

    def process_approval
      @approval.approved!
      flash[:notice] = "#{@subject} has been approved"
    end

    def process_rejection
      puts "Processing rejection"
      @approval.approval_status = :to_be_revised
      @approval.rejection_reason = params["approval"]["rejection_reason"].to_i
      @approval.approver = current_user
      if @approval.save
        flash[:notice] = "t(:#{@subject}_to_be_revised, scope: [:success])"
      else
        puts "What is wrong with this subject?: #{@approval.approvable.inspect}"
        flash[:error] = "t(:#{@subject}_not_approved, scope: [:failure])"
      end
    end

end  