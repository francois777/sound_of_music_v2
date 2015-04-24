class ArtistsController < ApplicationController

  before_filter :authenticate_user!, only: [:new, :create, :edit, :update]
  before_action :set_artist, except: [:new, :create, :index]

  def show
    @context = "Artists"
    @submitted_by = @artist.submitted_by.name
    @approval = @artist.approval
    authorize @artist
  end

  def index
    @context = "Artists"
    case params['filter'] 
    when 'approved'
      @artists = policy_scope(Artist).approved.paginate(page: params[:page])
    when 'submitted'
      @artists = policy_scope(Artist).submitted.paginate(page: params[:page])
    when 'under_revision'
      @artists = policy_scope(Artist).to_be_revised.paginate(page: params[:page])  
    else
      @artists = policy_scope(Artist).paginate(page: params[:page])
    end
  end

  def new
    @artist = Artist.new
    @artist.born_on = Date.today - 50.years
    4.times { @artist.artist_names.build }
  end

  def edit
    @artist.artist_names.build
  end

  def create
    @artist = Artist.new(artist_params_formatted)
    @artist.submitted_by = current_user
    if @artist.save
      create_approval(@artist.reload)
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

  def user_not_authorized
    flash[:alert] = "This artist is not yet approved. You may not perform this action."
    redirect_to (request.referrer || root_path)
  end

  private

    def create_approval(approvable)
      approval_params = Approval::SUBMITTED.merge( {approvable: @artist} )
      Approval.create( approval_params )
    end

    def artist_params_formatted
      new_params = artist_params
      inx = 0
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
    rescue
      flash[:alert] = t(:artist_not_found, scope: [:failure]) 
      redirect_to artists_path
    end

end