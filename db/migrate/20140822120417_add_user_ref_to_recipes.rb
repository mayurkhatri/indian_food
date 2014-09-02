class AddUserRefToRecipes < ActiveRecord::Migration
  def up
    change_table :recipes do |t|
      t.references :user
    end
    add_index :recipes, :user_id
  end

  def down
    change_table :recipes do |t|
      t.remove_references :user
    end
  end
end
