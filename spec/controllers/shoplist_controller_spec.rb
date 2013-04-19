require 'spec_helper'

describe ShoplistController, "adding a new ingredient" do

  login_user	
  
  it "should add ingredient to shop list" do
  	post :sync, :ingredients => [ { :ingredient => "cheetos", :group => "other", :status => "add" } ]
    ShopList.should_receive(:new).with(:ingredient => "cheetos", :group => "other", :user_id => @user_id)
  end
  
  it "should save ingredient" do
    ShopList.should_receive(:save).and_return(true)
    post :sync, :ingredients => [ { :ingredient => "cheetos", :group => "other", :status => "add" } ]
  end
  
end


