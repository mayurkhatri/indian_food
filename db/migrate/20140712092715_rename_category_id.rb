class RenameCategoryId < ActiveRecord::Migration
  def up
    rename_column :courses_dishes, :category_id, :course_id
    remove_index(:courses_dishes, :name => "index_categories_dishes_on_category_id_and_dish_id") if index_exists?(:courses_dishes, :name => "index_categories_dishes_on_category_id_and_dish_id")
    add_index(:courses_dishes, [:course_id, :dish_id])
  end

  def down
    rename_column :courses_dishes, :course_id, :category_id
    remove_index(:courses_dishes, :name => "index_courses_dishes_on_course_id_and_dish_id")
    add_index(:courses_dishes, [:category_id, :dish_id])
  end
end
