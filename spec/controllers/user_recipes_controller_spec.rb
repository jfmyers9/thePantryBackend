require 'spec_helper'

describe UserRecipeController, "adding a new recipe" do

	login_user

	before(:each) do
    	UserRecipe.stub!(:new).and_return(@user_rec = mock_model(UserRecipe, :save => true))
  	end

  	def do_create
  		post :sync, :recipes => [ {:cooked =>"true", :favorite => "true", :id => "Pasta", :name => "Pasta with Butter", 
    		:image => "http://google.com", :ingLines => "pasta,butter", :dirLines => "Boil water. Cook Pasta. Melt Butter. Eat", :status => "add"} ]
    end

    def do_create_del
  		post :sync, :recipes => [ {:cooked =>"true", :favorite => "true", :id => "Pasta", :name => "Pasta with Butter", 
    		:image => "http://google.com", :ingLines => "pasta,butter", :dirLines => "Boil water. Cook Pasta. Melt Butter. Eat", :status => "delete"} ]
    end

	it "has the specified paramters" do
		do_create
		controller.params[:recipes].should_not be_nil
		controller.params[:recipes].should eql [ {"cooked" =>"true", "favorite" => "true", "id" => "Pasta", "name" => "Pasta with Butter", 
    		"image" => "http://google.com", "ingLines" => "pasta,butter", "dirLines" => "Boil water. Cook Pasta. Melt Butter. Eat", "status" => "add"} ]
	end

	it "adds the specified recipe" do
		UserRecipe.should_receive(:new).with(:cooked =>"true", :favorite => "true", :recipe_id => "Pasta", :name => "Pasta with Butter", 
    		:imageUrl => "http://google.com", :ingLines => "pasta,butter",
    		:dirLines => "Boil water. Cook Pasta. Melt Butter. Eat", :user_id => @user_id).and_return(@user_rec)
		do_create
	end

	it "should save the shop_list item" do
    	@user_rec.should_receive(:save).and_return(true)
    	do_create
  	end

	it "deletes the specified item" do
		UserRecipe.should_receive(:delete_all).with(:recipe_id => "Pasta", :user_id => @user_id)
		do_create_del
	end
  
end

describe UserRecipeController, "adding an invalid recipe" do

	login_user

	before(:each) do
    	UserRecipe.stub!(:new).and_return(@user_rec = mock_model(UserRecipe, :save => true))
  	end

  	def do_create
  		post :sync, :recipes => [ {:cooked =>"true", :favorite => "true", :id => "Pasta", :name => "Pasta with Butter", 
    		:image => "http://google.com", :ingLines => "pasta,butter", :dirLines => "Boil water. Cook Pasta. Melt Butter. Eat", :status => "add"} ]
    end

    def do_create_del
  		post :sync, :recipes => [ {:cooked =>"true", :favorite => "true", :id => "Pasta", :name => "Pasta with Butter", 
    		:image => "http://google.com", :dirLines => "Boil water. Cook Pasta. Melt Butter. Eat", :status => "delete"} ]
    end

	it "has the specified paramters" do
		do_create
		controller.params[:recipes].should_not be_nil
		controller.params[:recipes].should eql [ {"cooked" =>"true", "favorite" => "true", "id" => "Pasta", "name" => "Pasta with Butter", 
    		"image" => "http://google.com", "ingLines" => "pasta,butter", "dirLines" => "Boil water. Cook Pasta. Melt Butter. Eat", "status" => "add"} ]
	end

	it "adds the specified recipe" do
		UserRecipe.should_receive(:new).with(:cooked =>"true", :favorite => "true", :recipe_id => "Pasta", :name => "Pasta with Butter", 
    		:imageUrl => "http://google.com", :ingLines => "pasta,butter",
    		:dirLines => "Boil water. Cook Pasta. Melt Butter. Eat", :user_id => @user_id).and_return(@user_rec)
		do_create
	end

	it "should not save the shop_list item" do
    	@user_rec.should_receive(:save).and_return(false)
    	do_create
  	end

	it "deletes the specified item" do
		UserRecipe.should_receive(:delete_all).with(:recipe_id => "Pasta", :user_id => @user_id)
		do_create_del
	end

end


