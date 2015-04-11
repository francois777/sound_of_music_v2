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
    authorize @article
  end

  def new
    @article = @subject.articles.new
  end 

  def create
    @article = @subject.articles.new(article_params) 
    @article.author = current_user
    @article.rejection_reason = :not_rejected
    @article.approval_status = :incomplete
    @article.theme_id = article_params[:theme_id].to_i
    if @article.save
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

  def update
    update_params = article_params
    update_params['theme_id'] = Theme.instruments.first.id.to_s if update_params['theme_id'].empty?
    if @article.update_attributes(update_params)
      flash[:notice] = "#{ t(:article_updated, scope: [:success])} (#{undo_link})"
      redirect_to [@subject, @article]
    else
      flash[:error] = t(:article_update_failed, scope: [:failure])
      redirect_to edit_instrument_article_path[@subject, @article]
    end
  end

  def user_for_paper_trail
    current_user.id
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

    def history
      @versions = PaperTrail::Version.order('created_at DESC')
    end

    def get_publishable
      # The subject could have various owners: instrument, artist, genre, historical period, maybe others..
      if params[:instrument_id].nil?
        @article = Article.find(params[:id])
        @subject = @article.publishable
      else
        @subject = Instrument.find(params[:instrument_id])
      end
    rescue
      @subject = nil
    end

    def article_params
      params.require(:article).permit(:title, :body, :theme_id, :publishable, :author )
    end

    def undo_link
      # puts "ArticlesController#undo_link"
      # puts "Versions: #{@article.versions.count}"
      if @article.versions.any?
        view_context.link_to("Undo", revert_version_path(@article.versions.last), method: :post)
      end
    end

    def redo_link
      params[:redo] == "true" ? link = "Undo that plz!" : link = "Redo that please!"
      view_context.link_to link, undo_path(@article_version.next, redo: !params[:redo]), method: :post
    end

end