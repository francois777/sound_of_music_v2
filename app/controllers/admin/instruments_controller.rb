class Admin::InstrumentsController < ApplicationController

  before_filter :authenticate_user!
  before_action :set_instrument

  def approve
    approve_params = instrument_params
    params[:commit] == "Approve" ? process_approval(approve_params) : process_rejection(approve_params)
  end

  private

    def process_approval(approve_params)
      if params["instrument"]["rejection_reason"] != 'not_rejected'
        flash[:alert] = t(:rejection_reason_does_not_apply, scope: [:failure])
      else  
        applied_params = instrument_params
        applied_params[:approval_status] = :approved
        applied_params[:rejection_reason] = :not_rejected
        @instrument.update_attributes(applied_params)
        flash[:success] = t(:instrument_approved, scope: [:success])
      end
      redirect_to @instrument
    end

    def process_rejection(approve_params)
      if params["instrument"]["rejection_reason"] == 'not_rejected'
        flash[:alert] = t(:rejection_reason_missing, scope: [:failure])
      else  
        applied_params = instrument_params
        applied_params[:approval_status] = :to_be_revised
        @instrument.update_attributes(applied_params)
        flash[:success] = t(:instrument_to_be_revised, scope: [:success])
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