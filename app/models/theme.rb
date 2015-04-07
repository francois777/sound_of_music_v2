class Theme < ActiveRecord::Base

  enum subject: [:artists, :instruments, :genres]
  
end