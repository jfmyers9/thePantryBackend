require 'spec_helper'

describe ShoplistController, "adding a new ingredient" do
  
  def do_post 
    post :sync, :ingredients => [ { :ingredient => "cheetos", :group => "other", :status => "add" } ]
  end
  
  it "should add ingredient to shop list" do
    ShopList.should_receive(:new).with("ingredient" => "cheetos", "group" => "other", "user_id" => current_user.id)
    do_post
  end
  
  it "should save ingredient" do
    ShopList.should_receive(:save).and_return(true)
    do_post
  end
  
end

