class CreateMainIngredients < ActiveRecord::Migration
  def change
    create_table :main_ingredients do |t|
      t.references :ingredient
      t.references :recipe
      t.boolean :is_main_ingredient, default: false

      t.timestamps
    end

    # TODO add a index according to what data is going to be fetched on UI
    add_index :main_ingredients, [:ingredient_id, :recipe_id]
  end
end
