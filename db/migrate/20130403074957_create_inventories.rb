class CreateInventories < ActiveRecord::Migration
  def change
    create_table :inventories do |t|
      t.string :ingredient
      t.integer :user_id

      t.timestamps
    end
  end
end
