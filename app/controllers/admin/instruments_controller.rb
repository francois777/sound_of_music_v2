class Admin::InstrumentsController < ApplicationController

  before_filter :authenticate_user!
  before_action :set_instrument

  def approve
  end

  private

    def process_approval(approve_params)
    end

    def process_rejection(approve_params)
    end

    def set_instrument
      @instrument = Instrument.find(params[:id])
    end

    def instrument_params
      params.require(:instrument).permit(:created_by, :approval_status, :rejection_reason)
    end        

  def 