class PhotoPolicy < ApplicationPolicy
  attr_reader :current_user, :model

  def initialize(current_user, model)
    @current_user = current_user
    @current_role = current_user ? current_user.role : 'visitor'
    @author = model.submitted_by
    @photo = model
  end

  def new?
  end

  def show?
    return false unless Photo.exists?(@photo.id)
    return true if @photo.approval.approved?
    @current_user and (@author == @current_user or @current_user.approver?)
  end

  def index?
    true
  end

  def edit?
    return false unless @current_user 
    return false if @photo.approval.submitted? and @author == @current_user
    return true if @author == @current_user
    @current_user.admin? or @current_user.approver? or @current_user.owner?
  end

  def submitted?
    true
  end

  def update?
    return false unless @current_user 
    return false if @photo.approval.submitted? and @author == @current_user
    return true if @author == @current_user
    @current_user.admin? or @current_user.approver? or @current_user.owner?
  end

  def approve?
    @current_user and @current_user.approver? and (@photo.approve.submitted? or @photo.approve.to_be_revised?) 
  end

  def destroy?
    current_user.admin?
  end

  def submit?
    return true if @photo.new_record?
    @author == @current_user and @photo.approval.to_be_revised?
  end

  def view_approval_info?
    return false unless @current_user
    @author == @current_user or @current_user.approver?
  end

  def for_approver?
    @current_user and @current_user.approver?
  end

  def photo_not_authorized
    flash[:alert] = "This operation is not allowed on photos."
    redirect_to (request.referrer or root_path)
  end

  # class Scope < Struct.new(:current_user, :model)
  #   def resolve
  #     if current_user.nil?
  #       model.articles.approved
  #     elsif current_user.user?  
  #       current_user.viewable_articles_for_instrument(model.id)
  #     else
  #       model.articles
  #     end  
  #   end    
  # end

end