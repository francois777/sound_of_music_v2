class Category < ActiveRecord::Base

  has_many :instruments
  has_many :subcategories
  
end