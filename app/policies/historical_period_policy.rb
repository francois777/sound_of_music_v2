class HistoricalPeriodPolicy < ApplicationPolicy
  attr_reader :current_user, :model

  def initialize(current_user, model)
    @current_user = current_user
    @current_role = current_user ? current_user.role : 'visitor'
    @artist = model
  end

  def new?
    return false unless @current_user 
    @current_user.admin? or @current_user.owner?
  end

  def show?
    true
  end

  def index?
    true
  end

  def edit?
    return false unless @current_user 
    @current_user.admin? or @current_user.owner?
  end

  def update?
    return false unless @current_user 
    @current_user.admin? or @current_user.owner?
  end

  def historical_period_not_authorized
    flash[:alert] = "This operation is not allowed on historical periods."
    redirect_to (request.referrer or historical_periods_path)
  end

end