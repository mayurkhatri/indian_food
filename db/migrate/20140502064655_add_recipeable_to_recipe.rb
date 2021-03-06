class AddRecipeableToRecipe < ActiveRecord::Migration
  def self.up
    change_table :recipes do |t|
      t.references :recipeable, polymorphic: true
    end
  end

  def self.down
    change_table :recipes do |t|
      t.remove_references :recipeable, polymorphic: true
    end
  end
end
