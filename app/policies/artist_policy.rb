class ArtistPolicy < ApplicationPolicy
  attr_reader :current_user, :model

  def initialize(current_user, model)
    @current_user = current_user
    @current_role = current_user ? current_user.role : 'visitor'
    @artist = model
    @author = model == Artist ? nil : model.submitted_by
  end

  def new?
    @current_user and (@artist.is_a?(Class) or @artist.new_record?)
  end

  def create?
    @current_user and @artist.new_record?
  end

  def show?
    return false unless Artist.exists?(@artist.id)
    return true if @artist.approved?
    @current_user and (@author == @current_user or @current_user.approver? or @current_user.owner?)
  end

  def index?
    true
  end

  def edit?
    return false unless @current_user 
    if @current_user.user?
      return false unless @author == @current_user
      return (@artist.submitted? or @artist.approved? or @artist.rejected?)
    end
    @current_user.admin? or @current_user.approver? or @current_user.owner?
  end

  def submitted?
    true
  end

  def update?
    return false unless @current_user 
    return false if @artist.approval.submitted? and @author == @current_user
    return false if @artist.approval.incomplete? and @author != @current_user
    return true if @author == @current_user
    @current_user.admin? or @current_user.approver? or @current_user.owner?
  end

  def approve?
    @current_user and @current_user.approver? and (@artist.approval.submitted? or @artist.approval.to_be_revised?)
  end

  def delete?
    return false unless @current_user
    return true if @current_user.approver? or @current_user.owner?
    !@artist.approved?
  end

  def destroy?
    current_user.admin?
  end

  def submit?
    return true if @artist.approval.incomplete?
    @author == @current_user and @artist.approval.to_be_revised?
  end

  def view_approval_info?
    return false unless @current_user
    @author == @current_user or @current_user.approver?
  end

  def for_approver?
    @current_user and @current_user.approver?
  end

  def artist_not_authorized
    flash[:alert] = "This operation is not allowed on artists."
    redirect_to (request.referrer or root_path)
  end

  class Scope < Struct.new(:current_user, :model)
    def resolve
      if current_user 
        if current_user.user?
          model.own_and_other_artists(current_user.id)
        else
          model.all
        end
      else
        model.approved
      end
    end
  end

end