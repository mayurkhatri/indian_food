class RenameCategoriesDishes < ActiveRecord::Migration
  def up
    rename_table :categories_dishes, :courses_dishes
  end

  def down
    rename_table :courses_dishes, :categories_dishes
  end
end
