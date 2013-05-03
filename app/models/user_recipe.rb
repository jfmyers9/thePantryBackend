class UserRecipe < ActiveRecord::Base

  attr_accessible :cooked, :favorite, :recipe_id, :image_url, :ing_lines, :name, :user_id, :dir_lines

  belongs_to :user
  
  validates :recipe_id, :presence => true
  validates :user_id, :presence => true
  validates :name, :presence => true
  validates :ing_lines, :presence => true
  validates :dir_lines, :presence => true

  validates_uniqueness_of :name, :recipe_id => [:user_id]

end
