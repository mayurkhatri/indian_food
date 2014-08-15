class Course < ActiveRecord::Base
  attr_accessible :name
  validates :name, :presence => { :message => "This field is required" }

  has_many :recipes, :as => :recipeable
 # accepts_nested_attributes_for :recipes
  has_and_belongs_to_many :dishes
end
