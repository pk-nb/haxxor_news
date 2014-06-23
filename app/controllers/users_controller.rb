class UsersController < ApplicationController
  before_action :in_valid_session?, only: [:show]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to :articles
    else
      flash.now[:error] = 'Was unsuccessful registering—please correct fields below'
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  private
  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end

  def in_valid_session?
    logger.debug "Should check for valid session here"
  end
end
