class PasswordResetsController < ApplicationController
  def new
    @password_reset = PasswordReset.new
  end

  def create
    @password_reset = PasswordReset.new(reset_params)
    if @password_reset.save
      redirect_to root_url, :notice => 'Password reset email sent'
    else
      flash.now[:error] = message = @password_reset.errors.full_messages.first
      render :new
    end
  end

  def edit
    @password_reset = PasswordReset.find(params[:id])
    if @password_reset.nil? || @password_reset.expired?
      flash[:error] = 'Password reset link expired' if @password_reset.expired?
      redirect_to root_url
    end
  end

  def update
    @password_reset = PasswordReset.find(params[:id])
    if @password_reset.update_attributes(reset_params)
      self.current_user = @password_reset.user
      flash[:notice] = 'Password successfully updated'
      redirect_to root_url
    else
      flash.now[:error] = 'Password was not updated—please correct fields below'
      render 'edit'
    end
  end

  private
  def reset_params
    params.require(:password_reset).permit(:email, :password, :password_confirmation)
  end
end
