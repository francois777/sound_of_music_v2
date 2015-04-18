class ArtistPolicy < ApplicationPolicy
  attr_reader :current_user, :model

  def initialize(current_user, model)
    @current_user = current_user
    @current_role = current_user.role
    @author = model.submitted_by
    @artist = model
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
    (@author == @current_user) or @current_user.admin? or @current_user.approval.approver? or @current_user.owner?
  end

  def submitted?
    true
  end

  def update?
    (@author == @current_user) or @current_user.admin? or @current_user.approval.approver? or @current_user.owner?
  end

  def approve?
    @artist.approval.submitted? and @current_user and @current_user.approver?
  end

  def destroy?
    current_user.admin?
  end

  def submit?
    return true if @artist.new_record?
    @author == @current_user and @artist.approval.to_be_revised?
  end

  def approve_info?
    return false unless @current_user
    @author == @current_user or @artist.approval.to_be_revised? or @artist.approval.submitted?
  end

  def for_approver?
    return false unless @current_user and @current_user.approver?
    @artist.approval.to_be_revised? or @artist.submitted?
  end

  def update_subcategories?
    # Dont know what this is needed
    true
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
        model.approval.approved
      end
    end
  end


end