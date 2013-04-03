require 'spec_helper'

describe ShopList do
  before { @test = ShopList.new(ingredient: "carrots", user_id: 2)}

  subject{ @test }
  
  it { should respond_to(:ingredient) }
  it { should respond_to(:user_id) }
  
  it { should be_valid }
  
  describe "duplicate entry" do
    @ingr = ShopList.new(ingredient: "carrots", user_id: 2)
    expect { @ingr.save }.to not_change { ShopList.count }
  end
  
  describe "no ingredient to add" do
    before { @test.ingredient = " " }
    it { should_not be_valid }
    after { @test.ingredient = "carrots" }
  end
  
  describe "no user id" do
    before { @test.user_id = nil }
    it { should_not be_valid }
    after { @test.user_id = 2 }
  end
end
