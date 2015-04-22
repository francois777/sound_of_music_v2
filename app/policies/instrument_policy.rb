class InstrumentPolicy < ApplicationPolicy
  attr_reader :current_user, :model

  def initialize(current_user, model)
    @current_user = current_user
    @current_role = current_user ? current_user.role : 'visitor'
    @author = model.created_by
    @instrument = model
  end

  def new?
  end

  def show?
    #return false unless Instrument.exists?(@instruments.id)
    return true if @instrument.approval.approved?
    @current_user and (@author == @current_user or @current_user.approver?)
  end

  def index?
    true
  end

  def edit?
    return false unless @current_user 
    return false if @instrument.approval.submitted? and @author == @current_user
    return false if @instrument.approval.incomplete? and @author != @current_user
    return true if @author == @current_user
    @current_user.admin? or @current_user.approver? or @current_user.owner?
  end

  def submitted?
    true
  end

  def update?
    return false unless @current_user 
    return false if @instrument.approval.submitted? and @author == @current_user
    return false if @instrument.approval.incomplete? and @author != @current_user
    return true if @author == @current_user
    @current_user.admin? or @current_user.approver? or @current_user.owner?
  end

  def approve?
    @current_user and @current_user.approver? and (@instrument.approve.submitted? or @instrument.approve.to_be_revised?) 
  end

  def destroy?
    current_user.admin?
  end

  def submit?
    return true if @instrument.new_record?
    @author == @current_user and @instrument.approval.to_be_revised?
  end

  def view_approval_info?
    return false unless @current_user
    @author == @current_user or @current_user.approver?
  end

  def for_approver?
    @current_user and @current_user.approver?
  end

  def instrument_not_authorized
    flash[:alert] = "This operation is not allowed on musical instruments."
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