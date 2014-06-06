class AddStartEndPreparationTimeToRecipes < ActiveRecord::Migration
  def up
    remove_column :recipes, :preparation_time
    add_column :recipes, :start_preparation_time, :integer, :default => 0
    add_column :recipes, :end_preparation_time, :integer, :default => 0
  end
  
  def down
    add_column :recipes, :preparation_time, :integer
    remove_column :recipes, :start_preparation_time
    remove_column :recipes, :end_preparation_time
  end
end
