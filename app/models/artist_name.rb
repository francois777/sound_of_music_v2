class ArtistName < ActiveRecord::Base

  belongs_to :artist
  
  enum name_type: [:first_name, :middle_name, :last_name, :public_name, :maiden_name]

  validates :name, presence: true, length: { minimum: 2, maximum: 20 }


end