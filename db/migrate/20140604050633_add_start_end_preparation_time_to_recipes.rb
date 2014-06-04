class AddStartEndPreparationTimeToRecipes < ActiveRecord::Migration
  def up
#    remove_column :recipes, :preparation_time
    add_column :recipes, :start_preparation_time, :integer
    add_column :recipes, :end_preparation_time, :integer
  end
  
  def down
    add_column :recipes, :preparation_time, :integer
    remove_column :recipes, :start_preparation_time
    remove_column :recipes, :end_preparation_time
  end
end
