def PasswordResetsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user.find_by email: params[:email]
    user.password_reset if user
    # Tell user email sent even if user doesn't exist
    flash[:notice] = 'Password reset email sent'
    redirect_to root_url
  end

  def edit
    @user = User.find_by! password_reset_token: params[:id]
  end
end
