class PasswordResetsController < ApplicationController
  def new
  	@title = "Recover password"
  end

  def create
  	user = User.find_by_email(params[:email])
  	user.send_password_reset if user
  	redirect_to root_url, notice: "Email send with password reset instructions"
  end

  def edit
  	@user = User.find_by_password_reset_token!(params[:id])
  	@title = "New password"
  end

  def update
  	@user = User.find_by_password_reset_token!(params[:id])
  	if @user.password_reset_sent_at < 2.hours.ago
  		flash[:success] = "Password reset has expired"
  		redirect_to new_password_reset_path
  	elsif @user.update_attributes(params.require(:user).permit(:password, :password_confirmation))
  		redirect_to root_url
  		flash[:success] = "Password has been reset!"
  	else
  		render :edit
  	end
  end
end
