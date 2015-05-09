class Theme < ActiveRecord::Base

  enum subject: [:artists, :instruments, :genres]

  scope :instruments, -> { 
    where("subject = ?", Theme.subjects[:instruments])
  } 
  scope :artists, -> { 
    where("subject = ?", Theme.subjects[:artists])
  } 
  
end