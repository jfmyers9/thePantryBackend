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
          if ingLines!= nil
            ingLines.downcase
          end
          status = item[:status]
          dirLines = item[:dirLines]
          if dirLines != nil
            dirLines.downcase
          end
          if status == "add"
            recipe = UserRecipe.new(:recipe_id => recipeId, :name => name, :cooked => cooked, :favorite => favorite,
             :image_url => image, :ing_lines => ingLines, :dir_lines => dirLines, :user_id => current_user.id )
            recipe.save
          elsif status == "delete"
            UserRecipe.delete_all(:user_id => current_user.id, :recipe_id => recipeId)
          end
        end
      end
      @recs = UserRecipe.find_all_by_user_id(current_user.id)
      @reclist = @recs.map do |rec|
        { :id => rec.recipe_id, :name => rec.name, :cooked => rec.cooked, :favorite => rec.favorite,
             :imgUrl => rec.image_url, :ingLines => rec.ing_lines, :dirLines => rec.dir_lines }
      end
      render :json => @reclist.to_json
    end
  end

  def search
    if params[:ingredients] != nil
      @recs = UserRecipe
      params[:ingredients].each do |ingredient|
        @recs = @recs.where("lower(ing_lines) like ? OR lower(name) like ?", "%" + ingredient.downcase + "%", "%" + ingredient.downcase + "%")
      end
      @reclist = @recs.map do |rec|
        { :id => rec.recipe_id, :name => rec.name, :cooked => rec.cooked, :favorite => rec.favorite,
             :imgUrl => rec.image_url, :ingLines => rec.ing_lines, :dirLines => rec.dir_lines }
      end
      render :json => @reclist.to_json
    end
  end

end
