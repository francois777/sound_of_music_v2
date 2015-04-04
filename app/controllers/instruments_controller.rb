class InstrumentsController < ApplicationController

  before_filter :authenticate_user!, only: [:create, :edit, :update, :submit]
  before_action :set_instrument, only: [:show, :edit, :update, :submit]

  def show
  end

  def new
    @instrument = Instrument.new
  end

  def edit
  end

  def create
  end

  def update
  end

  def index
    @instruments = Instrument.paginate(page: params[:page])
  end

  def submit
  end

  private

    def set_instrument
      @instrument = Instrument.find(params[:id].to_i)
    rescue
      @instrument = nil
    end

    def instrument_params
      params.require(:instrument).permit(:name, :other_names, 
        :performer_title, :category, :subcategory, :tuned, :origin_period)
    end
end