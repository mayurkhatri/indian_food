class CreateJoinTableOccassionRecipe < ActiveRecord::Migration
  def change
    create_table :occassions_recipes do |t|
      t.references :occassion
      t.references :recipe

      t.timestamps
    end
      add_index :occassions_recipes, [:occassion_id, :recipe_id]
  end
end
