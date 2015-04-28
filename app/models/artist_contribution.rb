class ArtistContribution < ActiveRecord::Base

  belongs_to :contribution_type
  belongs_to :artist

end