class AddStartEndCookingTimeToRecipes < ActiveRecord::Migration
  def up
    remove_column :recipes, :cooking_time
    add_column :recipes, :start_cooking_time, :integer, :default => 0
    add_column :recipes, :end_cooking_time, :integer, :default => 0
  end

  def down
    add_column :recipes, :cooking_time
    remove_column :recipes, :start_cooking_time
    remove_column :recipes, :end_cooking_time
  end
end
