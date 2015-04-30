class HistoricalPeriodsController < ApplicationController

  before_filter :authenticate_user!, only: [:new, :create, :edit, :update]
  before_action :set_historical_period, except: [:new, :create, :index]

  def show
  end

  def new
    @historical_period = HistoricalPeriod.new
    authorize @historical_period
  end

  def index
    @historical_periods = HistoricalPeriod.all
  end

  def create
    @historical_period = HistoricalPeriod.new(historical_period_params)
    if @historical_period.save
      flash[:notice] = t(:historical_period_created, scope: [:success])
      redirect_to @historical_period
    else
      flash[:alert] = t(:historical_period_create_failed, scope: [:failure])
      render :new
    end
  end

  def edit
    authorize @historical_period
  end

  def update
    if @historical_period.update_attributes(historical_period_params)
      flash[:notice] = t(:historical_period_updated, scope: [:success])
      redirect_to @historical_period
    else
      flash[:alert] = t(:historical_period_update_failed, scope: [:failure])
      render :edit
    end
  end

  def user_not_authorized
    flash[:alert] = "You are not authorised to perform this action on Historical Periods."
    redirect_to (request.referrer || historical_periods_path)
  end

  private

    def historical_period_params
      params.require(:historical_period).permit(:name, :period_from, :period_end, :overview)
    end

    def set_historical_period
      @historical_period = HistoricalPeriod.find(params[:id].to_i)
    rescue
      flash[:alert] = t(:historical_period_not_found, scope: [:failure]) 
      redirect_to historical_periods_path
    end

end