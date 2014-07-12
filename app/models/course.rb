class Course < ActiveRecord::Base
  attr_accessible :name
  
  has_many :recipes, :as => :recipeable
  has_and_belongs_to_many :dishes
end
