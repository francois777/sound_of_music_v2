class InstrumentPolicy < ApplicationPolicy
  attr_reader :current_user, :model

  def initialize(current_user, model)
    # puts "Inside InstrumentPolicy#initialize"
    # puts "Current user: #{current_user.inspect}"
    # puts "Model: #{model.inspect}"
    @current_user = current_user
    @current_role = current_user.role
    @author = model.created_by
    @instrument = model
  end

  def new?
  end

  def show?
    true
  end

  def index?
    true
  end

  def edit?
    return true if @author == @current_user or @current_user.admin?
  end

  def update?
    return true if @author == current_user or current_user.admin?
  end

  def destroy?
    current_user.admin?
  end

  def submit?
    return true if @instrument.new_record?
    @author == @current_user and @instrument.to_be_revised?
  end

  def approve?
    !@current_user.user?
  end

  def update_subcategories?
    # Dont know what this is needed
    true
  end

  def instrument_not_authorized
    flash[:alert] = "No way! This operation is not allowed on musical instruments."
    redirect_to (request.referrer or root_path)
  end

  class Scope < Struct.new(:current_user, :model)
    def resolve
      if current_user.user?
        puts "Evaluating the scope for #{current_user.name}"
        model.approved || model.where(created_by: current_user)
      else
        model.all
      end
    end
  end


end