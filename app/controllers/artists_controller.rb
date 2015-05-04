class ArtistsController < ApplicationController

  before_filter :authenticate_user!, only: [:new, :create, :edit, :update]
  before_action :set_artist, except: [:new, :create, :index]

  def show
    authorize @artist
    set_articles
    @context = "Articles" if @articles.any?
  end

  def index
    @context = "Artists"
    filter = params['filter'] || 'all'
    filter_artists(filter)
  end  

  def new
    @artist = Artist.new
    authorize @artist
    @artist.born_on = Date.today - 50.years
    4.times { @artist.artist_names.build }
  end

  def edit
    authorize @artist
    @artist.artist_names.build
  end

  def create
    @artist = Artist.new(artist_params_formatted)
    authorize @artist
    @artist.submitted_by = current_user
    if @artist.save
      create_approval
      flash[:notice] = t(:artist_submitted, scope: [:success])
      redirect_to @artist
    else
      flash[:alert] = t(:artist_submit_failed, scope: [:failure])
      render :new
    end
  end

  def update
    if @artist.update_attributes(artist_params_formatted)
      flash[:notice] = t(:artist_updated, scope: [:success])
      redirect_to @artist
    else  
      flash[:alert] = t(:artist_update_failed, scope: [:failure])
      render :edit
    end
  end

  def destroy
    @artist.delete
    flash[:notice] = t(:artist_deleted, scope: [:success])
    redirect_to artists_path
    authorize @artist
  end

  def user_not_authorized
    flash[:alert] = "This artist is not yet approved. You may not perform this action."
    redirect_to (request.referrer || root_path)
  end

  private

    def filter_artists(filter)
      if %w(approved submitted under_revision all).include? filter
        send "show_#{filter}_artists"
      elsif filter == "hist_period"
        show_artists_by_hist_period(params['name'])
      else
        show_all_artists
      end
    end

    def show_all_artists
      @artists = policy_scope(Artist).paginate(page: params[:page])
    end

    def show_approved_artists
      @artists = policy_scope(Artist).approved.paginate(page: params[:page])
    end

    def show_submitted_artists
      @artists = policy_scope(Artist).submitted.paginate(page: params[:page])
    end

    def show_under_revision_artists
      @artists = policy_scope(Artist).to_be_revised.paginate(page: params[:page]) 
    end
  
    def show_artists_by_hist_period(name)
      historical_period = HistoricalPeriod.find_historical_period_by_name(name)
      show_all_artists unless historical_period
    end

    def create_approval
      approval_params = Approval::SUBMITTED.merge( {approvable: @artist} )
      Approval.create( approval_params )
    end

    def artist_params_formatted
      new_params = artist_params
      inx = 0
      new_params['historical_period_id'] = artist_params['historical_period_id'].to_i
      while new_params['artist_names_attributes'][inx.to_s] != nil
        new_params['artist_names_attributes'][inx.to_s]['name_type'] = artist_params['artist_names_attributes'][inx.to_s]['name_type'].to_i
        inx += 1
      end
      new_params
    end

    def artist_params
      params.require(:artist).
        permit(:born_on, :died_on, :born_country_code, :historical_period_id, :gender, artist_names_attributes: [:id, :name, :name_type])
    end

    def set_artist
      @artist = Artist.find(params[:id].to_i)
      @artist.load
    rescue
      flash[:alert] = t(:artist_not_found, scope: [:failure]) 
      redirect_to artists_path
    end

    def set_articles
      @articles = Article.none
      return unless @artist.approved?
      scoped_articles = ArticlePolicy::Scope.new(current_user, Article, @artist).resolve
      apply_filter_to_articles(scoped_articles) if scoped_articles.any?
    end

    def apply_filter_to_articles(scoped_articles)
      filter = params['filter'] || 'all'
      if %w(all_for_publishable incomplete submitted under_revision all).include? filter
         articles = send("#{filter}_articles", scoped_articles)
         @articles = articles.collect { |art| { art_id: art.id, title: art.title, author_name: art.author.name, email: art.author.email, approval_status: art.approval_status_display, submitted_on: art.created_at }}
      end
    end
    
    def all_for_publishable_articles(scoped_articles)
      scoped_articles(@artist)
    end

    def incomplete_articles(scoped_articles)
      scoped_articles.incomplete(@artist)
    end

    def submitted_articles(scoped_articles)
      scoped_articles.submitted(@artist)
    end

    def under_revision_articles(scoped_articles)
      scoped_articles.to_be_revised(@artist)
    end

    def all_articles(scoped_articles)
      scoped_articles
    end

end