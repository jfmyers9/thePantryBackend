class CreateRecipes < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
      t.string :name
      t.string :recipeID
      t.string :ingredientLines
      t.string :image
      t.string :attribute
      t.string :source
      t.string :cooked
      t.string :favorite
      t.integer :user_id

      t.timestamps
    end
  end
end
