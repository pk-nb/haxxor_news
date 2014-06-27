class SessionsController <  ApplicationController
  skip_before_action :store_redirect_url
  def new
    @session = Session.new
  end

  def create
    @session = Session.new(session_params)

    if @session.valid?
      self.current_user = @session.user
      redirect_to redirect_url || :articles
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
end
