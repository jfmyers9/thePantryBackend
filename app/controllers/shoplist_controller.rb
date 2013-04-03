class ShoplistController < ApplicationController

	before_filter :authenticate_user!

	def sync
		if user_signed_in?
			if params[:ingredients] != nil
				params[:ingredients].each do |item|
					ingredient = item[:ingredient]
					group = item[:group]
					status = item[:status]
					if status == "add"
						slitem = ShopList.new(:ingredient => ingredient, :group => group, :user_id => current_user.id)
						slitem.save
					elsif status == "delete"
						ShopList.delete_all(:user_id => current_user.id, :group => group, :ingredient => ingredient)
					end
				end
			end
			@ingredients = ShopList.find_all_by_user_id(current_user.id)
			@inglist = @ingredients.map do |ing|
	  			{ :ingredient => ing.ingredient, :group => ing.group }
			end
			render :json => @inglist.to_json
		end
	end

end
