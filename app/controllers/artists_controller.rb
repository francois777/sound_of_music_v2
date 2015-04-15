class ArtistsController < ApplicationController


  private

    params.require(:artist).
       permit(:born_on, :died_on, :born_country_code, :historical_period_id, :gender, artist_names_attributes: [:name, :name_type])
end