class Recipe < ActiveRecord::Base
  attr_accessible :cooking_time, :information, :name, :preparation_method, :preparation_time, :serves
end
