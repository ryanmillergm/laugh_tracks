class Comedian < ApplicationRecord
  has_many :specials
  
  validates_presence_of :name
  validates_presence_of :age
  validates_presence_of :city
  validates_presence_of :image_url


end
