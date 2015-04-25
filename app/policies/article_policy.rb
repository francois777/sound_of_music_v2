class ArticlePolicy < ApplicationPolicy
  attr_reader :current_user, :model

  def initialize(current_user, model)
    @current_user = current_user
    @current_role = current_user ? current_user.role : 'visitor'
    @author = model.author
    @article = model
  end

  def new?
  end

  def show?
    return false unless Article.exists?(@article.id)
    return true if @article.approval.approved?
    @current_user and (@author == @current_user or @current_user.approver? or @current_user.owner?)
  end

  def delete?
    return false unless @current_user
    return true if @current_user.approver? or @current_user.owner?
    !@article.approved?
  end

  def index?
    true
  end

  def edit?
    return false unless @current_user 
    return false if @article.approval.submitted? and @author == @current_user
    return true if @author == @current_user
    @current_user.admin? or @current_user.approver? or @current_user.owner?
  end

  def submitted?
    true
  end

  def update?
    return false unless @current_user 
    return false if @article.approval.submitted? and @author == @current_user
    return true if @author == @current_user
    @current_user.admin? or @current_user.approver? or @current_user.owner?
  end

  def approve?
    @current_user and @current_user.approver? and (@article.approval.submitted? or @article.approval.to_be_revised?) 
  end

  def destroy?
    current_user.owner?
  end

  def submit?
    return true if @article.new_record?
    return true if @current_user.owner?
    @author == @current_user and (@article.approval.incomplete? or @article.approval.to_be_revised?)
  end

  def view_approval_info?
    return false unless @current_user
    @author == @current_user or @current_user.approver? or @current_user.owner?
  end

  def for_approver?
    @current_user and (@current_user.approver? or @current_user.owner?)
  end

  def article_not_authorized
    flash[:alert] = "This operation is not allowed on articles."
    redirect_to (request.referrer or root_path)
  end

  class Scope < Struct.new(:current_user, :model, :publishable)
    def resolve
      if current_user
        if current_user.user?
          model.own_and_other_articles(publishable, current_user.id)
        else
          model.all_for_publishable(publishable)
        end
      else
        model.approved(publishable)
      end  
    end    
  end

end