class CreateJoinTableCategoryDish < ActiveRecord::Migration
  def change
    create_table :categories_dishes do |t|
      t.references :category
      t.references :dish
    end

    add_index(:categories_dishes, [:category_id, :dish_id])
  end
end
