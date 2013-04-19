class UserRecipeController < ApplicationController
  before_filter :authenticate_user!
  
  def sync
    if user_signed_in?
      if params[:recipes] != nil
        params[:recipes].each do |item|
          name = item[:name]
          recipeId = item[:id]
          cooked = item[:cooked]
          favorite = item[:favorite]
          image = item[:image]
          ingLines = item[:ingLines]
          status = item[:status]
          dirLines = item[:dirLines]
          if status == "add"
            recipe = UserRecipe.new(:id => recipeId, :name => name, :cooked => cooked, :favorite => favorite,
             :imageUrl => image, :ingLines => ingLines, :dirLines => dirLines, :user_id => current_user.id )
            recipe.save
          elsif status == "delete"
            UserRecipe.delete_all(:user_id => current_user.id, :id => recipeId)
          end
        end
      end
      @recs = UserRecipe.find_all_by_user_id(current_user.id)
      @reclist = @recs.map do |rec|
        { :id => rec.id, :name => rec.name, :cooked => rec.cooked, :favorite => rec.favorite,
             :imgUrl => rec.imageUrl, :ingLines => rec.ingLines, :dirLines => rec.dirLines }
      end
      render :json => @reclist.to_json
    end
  end
end
