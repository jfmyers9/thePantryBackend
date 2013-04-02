class SessionsController < ApplicationController
	def new
	end

	def create
	  user = User.authenticate(params[:email], params[:password])
	  if user
	    session[:user_id] = user.id
	    render :json => { :errCode => 0 }
	  else
	    flash.now.alert = "Invalid email or password"
	    render :json => { :errCode => 1 }
	  end
	end

	def destroy
	  session[:user_id] = nil
	  render :json => { :errCode => 0 }
	end
end
