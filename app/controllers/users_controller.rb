class UsersController < ApplicationController
	def new
	  @user = User.new
	end

	def create
	  @user = User.new(params[:user])
	  if @user.save
	    render :json => { :errCode => 0 }
	  else
	    render :json => { :errCode => 1 }
	  end
	end
end
