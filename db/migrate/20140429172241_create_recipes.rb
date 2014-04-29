class CreateRecipes < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
      t.string :name
      t.string :information
      t.text :preparation_method
      t.datetime :preparation_time
      t.datetime :cooking_time
      t.integer :serves

      t.timestamps
    end
  end
end
