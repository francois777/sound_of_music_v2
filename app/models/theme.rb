class Theme < ActiveRecord::Base

  enum subject: [:artists, :instruments, :genres]

  scope :instruments, -> { 
    where("subject = ?", Theme.subjects[:instruments])
  } 
  
end