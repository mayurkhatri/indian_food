class Recipe < ActiveRecord::Base
  attr_accessible :cooking_time, :information, :name, :preparation_method, :preparation_time, :serves
  resourcify
  
  has_and_belongs_to_many :dishes
  belongs_to :recipeable, polymorphic: true
  has_many :ingredients, through: :main_ingredients
  has_and_belongs_to_many :occassions
  
  def self.calculate_minutes(hours, minutes)
    minutes = (hours.to_i * 60) + minutes.to_i
    minutes
  end
  
  def self.calculate_time(minutes)
   time = []
   time[0] = minutes / 60
   time[1] = (minutes % 60)
   time
  end
end
