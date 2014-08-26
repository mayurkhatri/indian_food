class AddUserRefToRecipes < ActiveRecord::Migration
  def self.up
    change_table :recipes do |t|
      t.references :user
    end
    add_index :recipes, :user_id
  end

  def self.down
    change_table :recipes do |t|
      t.remove_references :user
    end
  end
end
