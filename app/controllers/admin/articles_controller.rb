class Admin::ArticlesController < ApplicationController

  before_filter :authenticate_user!
  before_action :set_article

  def approve
    approve_params = article_params
    if authorize @article
      params[:commit] == "Approve" ? process_approval(approve_params) : process_rejection(approve_params)
    else
      flash[:error] = t(:approval_not_allowed, scope: [:failure])
    end  
    redirect_to [@subject, @article]
  end

  private

    def process_approval(approve_params)
      @article.approval_status = :approved
      @article.rejection_reason = :not_rejected
      @article.approver = current_user
      if @article.save
        flash[:notice] = t(:article_approved, scope: [:success])
      else
        puts "What is wrong with this article?: #{@article.inspect}"
        flash[:error] = t(:article_not_approved, scope: [:failure])
      end
      #redirect_to [@subject, @article]
    end

    def process_rejection(approve_params)
      @article.approval_status = :to_be_revised
      @article.rejection_reason = params["article"]["rejection_reason"].to_i
      @article.approver = current_user
      if @article.save
        flash[:notice] = t(:article_to_be_revised, scope: [:success])
      else
        puts "What is wrong with this article?: #{@article.inspect}"
        flash[:error] = t(:article_not_approved, scope: [:failure])
      end
      #redirect_to @instrument
    end

    def set_article
      @article = Article.find(params[:id])
      @subject = @article.publishable
    end

    def article_params
      params.require(:article).permit(:title, :body, :theme_id, :publishable, :author, :rejection_reason, :created_at )
    end

end