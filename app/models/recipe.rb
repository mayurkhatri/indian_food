class Recipe < ActiveRecord::Base
  attr_accessible :information, :name, :preparation_method, :start_cooking_time, :start_preparation_time, :end_cooking_time, :end_preparation_time, :serves
  resourcify
  
  has_and_belongs_to_many :dishes
  belongs_to :recipeable, polymorphic: true
  has_many :ingredients, through: :main_ingredients
  has_and_belongs_to_many :occassions
  
  def self.calculate_minutes(time, unit)
    if unit.eql?("hours")
      minutes = (time.to_i * 60)
    else
      minutes = time
    end
    minutes
  end
  
  def self.calculate_time(minutes)
   time = minutes.blank? ? 0 :(minutes % 60)
   time
  end
end
