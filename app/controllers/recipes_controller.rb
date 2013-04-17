class RecipesController < ApplicationController
  
  before_filter :authenticate_user!
  
  def sync
    if user_signed_in?
      if params[:recipes] != nil
        params[:recipes].each do |item|
          name = item[:name]
          recipeId = item[:recipeID]
          cooked = item[:cooked]
          favorite = item[:faved]
          image = item[:image]
          ingredLines = item[:ingredLines]
          source = item[:source]
          att = item[:att]
          status = item[:status]
          if status == "add"
            recItem = Recipe.new(:recipeID => recipeId, :name => name, :cooked => cooked, :favorite => favorite,
             :image => image, :ingredientLines => ingredLines, :source => source, :attribute => att, :user_id => current_user.id)
            recItem.save
          elsif status == "delete"
            Recipe.delete_all(:user_id => current_user.id, :recipeID => recipeId)
          end
        end
      end
      @recs = Recipe.find_all_by_user_id(current_user.id)
      @reclist = @recs.map do |rec|
        { :recipeID => rec.recipeID, :name => rec.name, :cooked => rec.cooked, :favorite => rec.favorite,
             :image => rec.image, :ingredLines => rec.ingredientLines, :source => rec.source, :attribute => rec.attribute }
      end
      render :json => @reclist.to_json
    end
  end
  
end
