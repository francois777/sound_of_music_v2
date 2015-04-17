class ArtistsController < ApplicationController

  before_filter :authenticate_user!, only: [:create, :edit, :update, :submit]
  before_action :set_artist, except: [:new, :create, :index]
  before_action :initialise_default_artist

  def show
    @context = "Artists"
    @submitted_by = @artist.submitted_by.name
  end

  def index
    @context = "Artists"
    @artists = Artist.all
  end

  def new
    @artist = Artist.new
    @artist.born_on = Date.today - 50.years
    @artist.artist_names.build
    @artist.artist_names.build
  end

  def edit
    @artist.artist_names.build
  end

  def create
    puts "Params: #{params}"
    @artist = Artist.new(artist_params_formatted)
    @artist.submitted_by = current_user
    if @artist.save
      flash[:notice] = t(:artist_submitted, scope: [:success])
      redirect_to @artist
    else
      flash[:alert] = t(:artist_submit_failed, scope: [:failure])
      set_default_categories
      render :new
    end
  end

  private

    def initialise_default_artist
    end

    def artist_params_formatted
      new_params = artist_params
      new_params['artist_names_attributes']['0']['name_type'] = artist_params['artist_names_attributes']['0']['name_type'].to_i
      new_params['artist_names_attributes']['1']['name_type'] = artist_params['artist_names_attributes']['1']['name_type'].to_i
      new_params
    end

    def artist_params
      params.require(:artist).
        permit(:born_on, :died_on, :born_country_code, :historical_period_id, :gender, artist_names_attributes: [:name, :name_type])
    end

    def set_artist
      @artist = Artist.find(params[:id].to_i)
    rescue
      flash[:alert] = t(:artist_not_found, scope: [:failure]) 
      redirect_to artists_path
    end

end