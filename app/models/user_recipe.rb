class UserRecipe < ActiveRecord::Base

  attr_accessible :cooked, :favorite, :recipe_id, :imageUrl, :ingLines, :name, :user_id, :dirLines

  belongs_to :user
  
  validates :recipe_id, :presence => true
  validates :user_id, :presence => true
  validates :name, :presence => true
  validates :ingLines, :presence => true
  validates :dirLines, :presence => true

end
