class RenameCategories < ActiveRecord::Migration
  def up
    rename_table :categories, :courses
  end

  def down
    rename_table :courses, :categories
  end
end
