class CreateJoinTableDishRecipe < ActiveRecord::Migration
  def change
    create_table :dishes_recipes, :id => false do |t|
      t.references :dish, :null => false
      t.references :recipe, :null => false
    end

    add_index(:dishes_recipes, [:dish_id, :recipe_id])
  end
end
