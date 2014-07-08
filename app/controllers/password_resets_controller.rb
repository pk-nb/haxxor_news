class PasswordResetsController < ApplicationController
  def new
    @password_reset = PasswordReset.new
  end

  def create
    @password_reset = PasswordReset.new(reset_params)
    if @password_reset.valid?
      user = User.find_by email: params[:password_reset][:email]
      user.password_reset if user
      # Tell user email sent even if user doesn't exist
      flash[:notice] = 'Password reset email sent'
      redirect_to root_url
    else
      flash.now[:error] = 'Please enter in a valid email address'
      render :new
    end
  end

  def edit
    @user = User.find_by password_reset_token: params[:id]
    if @user && !@user.password_reset_expired?
      @password_reset = PasswordReset.new
    else
      flash[:error] = 'Password reset link expired' if @user.password_reset_expired?
      redirect_to root_url
    end
  end

  def update
    @password_reset = PasswordReset.new(reset_params)
    if @password_reset.valid?
      @user = User.find_by password_reset_token: params[:id]
      if @password_reset.update_user(@user)
        flash[:notice] = 'Password successfully updated'
      else
        flash[:error] = 'Could not update password'
      end
      redirect_to root_url
    else
      flash.now[:error] = 'Password was not updated—please correct fields below'
      render :edit
    end
  end

  private
  def reset_params
    params.require(:password_reset).permit(:email, :password, :password_confirmation)
  end
end
