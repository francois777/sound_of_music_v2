class PhotoPolicy < ApplicationPolicy
  attr_reader :current_user, :model

  def initialize(current_user, model)
    @current_user = current_user
    @current_role = current_user ? current_user.role : 'visitor'
    @submitted_by = model.submitted_by
    @photo = model
  end

  def new?
  end

  def show?
    return false unless Photo.exists?(@photo.id)
    return true if @photo.approved?
    @current_user and (@submitted_by == @current_user or @current_user.approver?)
  end

  def index?
    true
  end

  def edit?
    return false unless @current_user 
    return true if @created_by == @current_user
    @current_user.admin? or @current_user.approver? or @current_user.owner?
  end

  def submitted?
    true
  end

  def update?
    return false unless @current_user 
    return true if @submitted_by == @current_user
    @current_user.admin? or @current_user.approver? or @current_user.owner?
  end

  def approve?
    @photo.submitted? and @current_user and @current_user.approver?
  end

  def destroy?
    current_user.admin?
  end

  def submit?
    return true if @photo.new_record?
    @submitted_by == @current_user and @photo.to_be_revised?
  end

  def view_approval_info?
    return false unless @current_user
    @submitted_by == @current_user or @current_user.approver?
  end

  def for_approver?
    @current_user and @current_user.approver?
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