class ShopList < ActiveRecord::Base

	belongs_to :user

	attr_accessible :ingredient, :user_id

	validates :ingredient, :presence => true
	validates :user_id, :presence => true

	validates_uniqueness_of :ingredient, :scope => [:user_id]

end
