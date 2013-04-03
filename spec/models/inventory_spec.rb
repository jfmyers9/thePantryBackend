require 'spec_helper'

describe Inventory do
  before { @test = Inventory.new(ingredient: "carrots", group: "vegetable", user_id: 2)}

  subject{ @test }
  
  it { should respond_to(:ingredient) }
  it { should respond_to(:user_id) }
  it { should respond_to(:group) }
  
  it { should be_valid }
  
  it "does not change number of inventory items with duplicate entry" do
    @ingr = Inventory.new(ingredient: "carrots", group: "vegetable", user_id: 2)
    expect { @ingr.save }.to change { Inventory.count }.by(0)
  end
  
  describe "no ingredient to add" do
    before do
      @test.ingredient = " "
    end
    it { should_not be_valid }
    after { @test.ingredient = "carrots" }
  end
  
  describe "no user id" do
    before do
      @test.user_id = nil
    end
    it { should_not be_valid }
    after { @test.user_id = 2 }
  end
end
