class ShoplistController < ApplicationController

	before_filter :authenticate_user!

	def sync
		if user_signed_in?
			if params[:ingredients] != nil
				params[:ingredients].each do |item|
					ingredient = item[:ingredient]
					status = item[:status]
					if status == "add"
						slitem = Inventory.new(:ingredient => ingredient, :user_id => current_user.id)
						slitem.save
					elsif status == "delete"
						Inventory.delete_all(:user_id => current_user.id, :ingredient => ingredient)
					end
				end
			end
			@ingredients = Inventory.find_all_by_user_id(current_user.id)
			@inglist = @ingredients.map do |ing|
	  			{ :ingredient => ing.ingredient }
			end
			render :json => @inglist.to_json
		end
	end

end
