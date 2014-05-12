class MainIngredient < ActiveRecord::Base
#  attr_accessible :title, :body
  belongs_to :recipe
  belongs_to :ingredient
end
