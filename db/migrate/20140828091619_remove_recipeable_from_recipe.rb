class RemoveRecipeableFromRecipe < ActiveRecord::Migration
  def up
    change_table :recipes do |t|
      t.remove_references :recipeable, polymorphic: true
    end
  end

  def down
    change_table :recipes do |t|
      t.references :recipeable, polymorphic: true
    end
  end
end
