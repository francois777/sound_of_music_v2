class InstrumentPolicy < ApplicationPolicy
  attr_reader :current_user, :model

  def initialize(current_user, model)
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
    puts "Applying index scope for instruments"
    true
  end

  def edit?
    (@author == @current_user) or @current_user.admin? or @current_user.approver? or @current_user.owner?
  end

  def submitted?
    true
  end

  def update?
    (@author == @current_user) or @current_user.admin? or @current_user.approver? or @current_user.owner?
  end

  def approve?
    @instrument.submitted? and @current_user and @current_user.approver?
  end

  def destroy?
    current_user.admin?
  end

  def submit?
    return true if @instrument.new_record?
    @author == @current_user and @instrument.to_be_revised?
  end

  def approve_info?
    return false unless @current_user
    @author == @current_user or @instrument.to_be_revised? or @instrument.submitted?
  end

  def for_approver?
    return false unless @current_user and @current_user.approver?
    @instrument.to_be_revised? or @instrument.submitted?
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
      if current_user 
        if current_user.user?
          model.own_and_other_instruments(current_user.id)
        else
          model.all
        end
      else
        model.approved
      end
    end
  end


end