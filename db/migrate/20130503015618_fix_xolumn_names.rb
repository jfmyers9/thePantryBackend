class FixXolumnNames < ActiveRecord::Migration
  def up
  end

  def change
    rename_column :user_recipes, :ingLines, :ing_lines
    rename_column :user_recipes, :dirLines, :dir_lines
    rename_column :user_recipes, :imageUrl, :image_url
    rename_column :recipes, :recipeID, :recipe_id
    rename_column :recipes, :ingredientLines, :ingredient_lines
  end

  def down
  end
end
