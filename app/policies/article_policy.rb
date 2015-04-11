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
    return true if @article.approved?
    return false unless Article.exists?(@article.id)
    @current_user and (@author == @current_user or @current_user.approver?)
  end

  def index?
    true
  end

  def edit?
    return false unless @current_user 
    return true if @author == @current_user
    return false if @article.incomplete? or @article.submitted?
    @current_user.admin? or @current_user.approver? or @current_user.owner?
  end

  def submitted?
    true
  end

  def update?
    return false unless @current_user 
    return true if @author == @current_user
    return false if @article.incomplete? or @article.submitted?
    @current_user.admin? or @current_user.approver? or @current_user.owner?
  end

  def approve?
    @article.submitted? and @current_user and @current_user.approver?
  end

  def destroy?
    current_user.admin?
  end

  def submit?
    return true if @article.new_record?
    @author == @current_user and @article.to_be_revised?
  end

  def view_approval_info?
    return false unless @current_user
    @author == @current_user or @current_user.approver?
  end

  def for_approver?
    @current_user and @current_user.approver?
  end

  class Scope < Struct.new(:current_user, :model)
    def resolve
      if current_user.nil?
        model.articles.approved
      end
      if current_user.user?  
        current_user.viewable_articles_for_instrument(model.id)
      else
        model.articles
      end  
    end    
  end

end