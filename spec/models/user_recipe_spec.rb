require 'spec_helper'

describe UserRecipe do
  before { @test = UserRecipe.new(cooked: "true", favorite: "true", recipe_id: "Pasta", name: "Pasta with Butter", 
    image_url: "http://google.com", user_id: 1, ing_lines: "pasta,butter", dir_lines: "Boil water. Cook Pasta. Melt Butter. Eat" ) }

  subject{ @test }
  
  it { should respond_to(:cooked) }
  it { should respond_to(:favorite) }
  it { should respond_to(:name) }
  it { should respond_to(:image_url) }
  it { should respond_to(:user_id) }
  it { should respond_to(:ing_lines) }
  it { should respond_to(:dir_lines) }
  
  it { should be_valid }
  
  describe "recipe" do
    before do
      @test.name = " "
    end
    it { should_not be_valid }
    after { @test.name = "Pasta with Butter" }
  end
  
  describe "no user id" do
    before do
      @test.user_id = nil
    end
    it { should_not be_valid }
    after { @test.user_id = 1 }
  end

  describe "no recipe id" do
    before do
      @test.recipe_id = nil
    end
    it { should_not be_valid }
    after { @test.recipe_id = "Pasta" }
  end

  describe "no Ingredient Lines" do
    before do
      @test.ing_lines = nil
    end
    it { should_not be_valid }
    after { @test.ing_lines = "pasta,butter" }
  end

  describe "no Direction Lines" do
    before do
      @test.dir_lines = nil
    end
    it { should_not be_valid }
    after { @test.dir_lines = "Boil water. Cook Pasta. Melt Butter. Eat" }
  end

  it "Does not Add Recipe with duplicate User_id, Recipe_Id, and Name" do
    @ingr = UserRecipe.new(cooked: "true", favorite: "true", recipe_id: "Pasta", name: "Pasta with Butter", 
      image_url: "http://google.com", user_id: 1, ing_lines: "pasta,butter", dir_lines: "Boil water. Cook Pasta. Melt Butter. Eat" )
    @test.save
    expect { @ingr.save }.to change { UserRecipe.count }.by(0)
  end

end
