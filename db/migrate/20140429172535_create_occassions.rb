class CreateOccassions < ActiveRecord::Migration
  def change
    create_table :occassions do |t|
      t.string :name

      t.timestamps
    end
  end
end
