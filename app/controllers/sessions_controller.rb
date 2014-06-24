class SessionsController <  ApplicationController
  def new
    @session = Session.new
  end

  def create
    @session = Session.new(session_params)

    if @session.valid?
      self.current_user = @session.user
      redirect_to :articles
    else
      flash.now[:error] = 'The login and password combination is not valid'
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to :articles
  end

  private
  def session_params
    params.require(:session).permit(:login, :password)
  end

  def current_user=(user)
    @current_user= user
    session[:user_id] = @current_user.id
  end
end
