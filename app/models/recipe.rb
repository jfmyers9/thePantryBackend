class Recipe < ActiveRecord::Base
  attr_accessible :attribute, :cooked, :favorite, :image, :ingredientLines, :name, :recipeID, :source, :user_id
  
  belongs_to :user
  
  validates :recipeID, :presence => true, :uniqueness => true
  validates :user_id, :presence => true
  validates :name, :presence => true
  validates :ingredientLines, :presence => true
end
