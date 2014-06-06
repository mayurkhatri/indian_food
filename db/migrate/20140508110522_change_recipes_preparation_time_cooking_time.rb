 class ChangeRecipesPreparationTimeCookingTime < ActiveRecord::Migration
  def up
    change_table :recipes do |t|
      t.change :preparation_time, :integer
      t.change :cooking_time, :integer
    end
  end

  def down
    change_table :recipes do |t|
      t.change :preparation_time, :datetime
      t.change :cooking_time, :datetime
    end
  end
end
