require 'spec_helper'

describe InventoryController, "adding a new ingredient" do

	login_user

	before(:each) do
    	Inventory.stub!(:new).and_return(@inv_item = mock_model(Inventory, :save => true))
  	end

	it "has the specified paramters" do
		post :sync, :ingredients => [{ :ingredient => "carrots", :group => "produce", :status => "add" }]
		controller.params[:ingredients].should_not be_nil
		controller.params[:ingredients].should eql [{ "ingredient" => "carrots", "group" => "produce", "status" => "add" }]
	end

	it "adds the specified item" do
		Inventory.should_receive(:new).with(:ingredient => "taco", :group => "other", :user_id => @user_id).and_return(@inv_item)
		post :sync, :ingredients => [{:ingredient => "taco", :group => "other", :status => "add"}]
	end

	it "should save the shop_list item" do
    	@inv_item.should_receive(:save).and_return(true)
    	post :sync, :ingredients => [{:ingredient => "taco", :group => "other", :status => "add"}]
  	end

	it "deletes the specified item" do
		Inventory.should_receive(:delete_all).with(:ingredient => "taco", :group => "other", :user_id => @user_id)
		post :sync, :ingredients => [{:ingredient => "taco", :group => "other", :status => "delete"}]
	end
  
end

describe InventoryController, "adding an invalid ingredient" do

	login_user

	before(:each) do
    	Inventory.stub!(:new).and_return(@inv_item = mock_model(Inventory, :save => true))
  	end

	it "has the specified paramters" do
		post :sync, :ingredients => [{:group => "produce", :status => "add" }]
		controller.params[:ingredients].should_not be_nil
		controller.params[:ingredients].should eql [{"group" => "produce", "status" => "add" }]
	end

	it "adds the specified item" do
		Inventory.should_receive(:new).with(:ingredient=>nil,:group => "other", :user_id => @user_id).and_return(@inv_item)
		post :sync, :ingredients => [{:group => "other", :status => "add"}]
	end

	it "should not save the shop_list item" do
    	@inv_item.should_receive(:save).and_return(false)
    	post :sync, :ingredients => [{:group => "other", :status => "add"}]
  	end

	it "deletes the specified item group" do
		Inventory.should_receive(:delete_all).with(:ingredient => nil, :group => "other", :user_id => @user_id)
		post :sync, :ingredients => [{:group => "other", :status => "delete"}]
	end

end


