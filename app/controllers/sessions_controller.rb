class SessionsController < ApplicationController
  def new
    # render login form in sessions/new.html.erb
  end

def create
  # 1. Find user by email
  @user = User.find_by(email: params["email"])

  # 2 & 3. Check password using BCrypt
  if @user != nil
    if BCrypt::Password.new(@user["password"]) == params["password"]
      cookies["zebra"]= "giraffe"
      session["user_id"] = @user["id"]

      flash["notice"] = "Welcome."
      redirect_to "/companies"
    else
      # Wrong password
      flash["notice"] = "Invalid email or password."
      redirect_to "/login"
    end
  else
    # 4. User doesn't exist
    flash["notice"] = "Invalid email or password."
    redirect_to "/login"
  end
end

  def destroy
    # logout the user
    session["user_id"] = nil
    flash["notice"] = "Goodbye."
    redirect_to "/login"
  end
end
