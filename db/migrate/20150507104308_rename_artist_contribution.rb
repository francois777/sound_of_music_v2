class RenameArtistContribution < ActiveRecord::Migration
  def self.up
    rename_table :artist_contribution, :artist_contributions
  end

  def self.down
    rename_table :artist_contributions, :artist_contribution
  end
end
