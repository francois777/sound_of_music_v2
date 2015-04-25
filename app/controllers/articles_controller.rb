class ArticlesController < ApplicationController

  before_filter :authenticate_user!, only: [:new, :create, :edit, :update, :submit, :approve]
  before_action :get_publishable
  before_action :set_article, only: [:show, :edit, :update, :submit, :destroy]
  before_action :set_instrument_themes, only: [:new, :edit]

  def show
    if @subject.nil?
      flash[:error] = t(:article_not_found, scope: [:failure])
      redirect_to instruments_path
      return
    end
    @approval = @article.approval
    authorize @article
  end

  def new
    @article = @subject.articles.new
  end 

  def create
    set_new_article_defaults
    if @article.save
      create_approval(@article.reload)
      flash[:notice] = t(:article_created, scope: [:success])
      redirect_to [@subject, @article]
    else
      flash[:error] = t(:article_create_failed, scope: [:failure])
      set_instrument_themes
      get_publishable
      render :new
    end
  end

  def edit
    authorize @article
  end

  def destroy
    @article.delete
    flash[:notice] = t(:article_deleted, scope: [:success])
    # keep as example: redirect_to :controller => 'articles', :action => 'edit', :id => 3, subject: @subject
    redirect_to :controller => @subject.class.name.downcase.pluralize, :action => 'show', id: @subject.id
  end

  def update
    update_params = article_params
    update_params['theme_id'] = Theme.instruments.first.id.to_s if update_params['theme_id'].empty?
    if @article.update_attributes(update_params)
      flash[:notice] = "#{ t(:article_updated, scope: [:success])} (#{undo_link})"
      redirect_to [@subject, @article]
    else
      flash[:error] = t(:article_update_failed, scope: [:failure])
      set_instrument_themes
      render :edit, subject: @subject, article: @article
    end
  end

  def user_for_paper_trail
    current_user.id if current_user
  end

  def undo
    @article_version = PaperTrail::Version.find_by_id(params[:id])
    begin
      if @article_version.reify
        @article_version.reify.save
      else
        # For undoing the create action
        @article_version.item.destroy
      end
      flash[:notice] = "Undid that! #{redo_link}"
    rescue
      flash[:alert] = "Failed undoing the action..."
    ensure
      redirect_to root_path
    end
  end

  def user_not_authorized
    flash[:alert] = "This article is protected. You may not perform this action.."
    redirect_to (request.referrer || root_path)
  end

  private

    def create_approval(approvable)
      approval_params = Approval::INCOMPLETE.merge( {approvable: @article} )
      Approval.create( approval_params )
    end

    def set_article
      if !@subject.nil? && !params[:id].empty?
        @article = Article.find(params[:id]) 
        @subject = @article.publishable
      end
    rescue  
      @article = nil
    end

    def set_instrument_themes
      @instrument_themes = Theme.instruments
    end

    def set_new_article_defaults
      @article = @subject.articles.new(article_params) 
      @article.author = current_user
      @article.theme_id = article_params[:theme_id].to_i
    end    

    def history
      @versions = PaperTrail::Version.order('created_at DESC')
    end

    def get_publishable
      # The subject could have various owners: instrument, artist, genre, historical period, maybe others..
      if params[:instrument_id]
        @subject = Instrument.find(params[:instrument_id])
      elsif params[:artist_id]
        @subject = Artist.find(params[:artist_id])
      else      
        @article = Article.find(params[:id])
        @subject = @article.publishable
      end
    rescue
      @subject = nil
    end

    def article_params
      params.require(:article).permit(:title, :body, :theme_id, :publishable, :author )
    end

    def undo_link
      if @article.versions.any?
        view_context.link_to("Undo", revert_version_path(@article.versions.last), method: :post)
      end
    end

    def redo_link
      params[:redo] == "true" ? link = "Undo that plz!" : link = "Redo that please!"
      view_context.link_to link, undo_path(@article_version.next, redo: !params[:redo]), method: :post
    end

end