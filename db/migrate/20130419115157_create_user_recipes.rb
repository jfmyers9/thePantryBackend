class CreateUserRecipes < ActiveRecord::Migration
  def change
    create_table :user_recipes do |t|
      t.string :name
      t.string :recipe_id
      t.integer :user_id
      t.string :ingLines
      t.string :imageUrl
      t.string :cooked
      t.string :favorite
      t.string :dirLines

      t.timestamps
    end
  end
end
