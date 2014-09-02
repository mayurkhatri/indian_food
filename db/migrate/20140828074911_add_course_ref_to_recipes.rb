class AddCourseRefToRecipes < ActiveRecord::Migration
  def up
    change_table :recipes do |t|
      t.references :course
    end
    add_index :recipes, :course_id
  end

  def down
    change_table :recipes do |t|
      t.remove_references :course
    end

  end
end
