require 'spec_helper'

describe User do
	before { @test = User.new(email: "user1@example.com", password: "password1", password_confirmation: "password1")}

	subject{ @test }

	it { should respond_to(:email) }
	it { should respond_to(:password) }
	it { should respond_to(:password_confirmation) }

	it { should be_valid }

	describe "when email is not present" do
		before { @test.email = " " }
		it { should_not be_valid }
		after { @test.email = "user1@example.com" }
	end

	describe "when password is not present" do
		before do
			@test.password = ""
		end
		it { should_not be_valid }
		after { @test.password = "password1" }
	end

	it "changes the number of Users" do
		@user = User.new(email: "user@example.com", password: "password", password_confirmation: "password");
		expect { @user.save }.to change { User.count }.by(1)
	end

end
