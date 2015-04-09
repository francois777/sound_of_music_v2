class Admin::InstrumentsController < ApplicationController

  before_filter :authenticate_user!
  before_action :set_instrument

  def approve
    approve_params = instrument_params
    if authorize @instrument
      params[:commit] == "Approve" ? process_approval(approve_params) : process_rejection(approve_params)
    else
      flash[:error] = t(:approval_not_allowed, scope: [:failure])
    end  
  end

  private

    def process_approval(approve_params)
      applied_params = instrument_params
      applied_params[:approval_status] = :approved
      applied_params[:rejection_reason] = :not_rejected
      @instrument.approver = current_user
      if @instrument.update_attributes(applied_params)
        flash[:notice] = t(:instrument_approved, scope: [:success])
      else
        puts "What is wrong with this instrument: #{@instrument.inspect}"
        flash[:error] = t(:instrument_not_approved, scope: [:failure])
      end
      redirect_to @instrument
    end

    def process_rejection(approve_params)
      if params["instrument"]["rejection_reason"] == 'not_rejected'
        flash[:alert] = t(:rejection_reason_missing, scope: [:failure])
      else  
        applied_params = instrument_params
        applied_params[:approval_status] = :to_be_revised
        applied_params[:rejection_reason] = instrument_params['rejection_reason'].to_i
        @instrument.approver = current_user
        @instrument.update_attributes(applied_params)
        flash[:notice] = t(:instrument_to_be_revised, scope: [:success])
      end
      redirect_to @instrument
    end

    def set_instrument
      @instrument = Instrument.find(params[:id])
    end

    def instrument_params
      params.require(:instrument).permit(:created_by, :approval_status, :rejection_reason)
    end        

end