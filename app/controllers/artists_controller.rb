class ArtistsController < ApplicationController

  before_filter :authenticate_user!, only: [:create, :edit, :update, :submit]
  before_action :set_artist, except: [:new, :create, :index]

  def show
    @context = "Artists"
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
      # Parameters: {"utf8"=>"✓", "authenticity_token"=>"ELiv...mzbvJ==", 
      # "artist"=>{"artist_names_attributes"=>{"0"=>{"name"=>"Aimee", "name_type"=>"0"}, 
      #                                        "1"=>{"name"=>"Maddison", "name_type"=>"2"}}, 
      # "gender"=>"female", "born_on"=>"29 Apr 1984", "died_on"=>"", "born_country_code"=>"cz"}, 
      # "commit"=>"Create new artist"} 
    redirect_to new_artist_path  
  end

  private

    def artist_params
      params.require(:artist).
       permit(:born_on, :died_on, :born_country_code, :historical_period_id, :gender, artist_names_attributes: [:name, :name_type])
    end

end