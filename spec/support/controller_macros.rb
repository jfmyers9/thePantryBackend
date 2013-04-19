module ControllerMacros

  def login_user
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      @user = User.create(email: "jim@jim.com", password: "password", password_confirmation: "password")
      @user.save
      #user.confirm!
      sign_in :user, @user
      @user_id = @user.id
    end
  end

end