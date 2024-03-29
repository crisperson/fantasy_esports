class SessionsController < ApplicationController
  def create
    render 'new'
  end

  def create
    user = User.find_by(aka: params[:session][:aka].downcase)
    if user && user.authenticate(params[:session][:password])
      sign_in user
      redirect_back_or user
    else
      flash.now[:error] = 'Invalid aka/password combination'
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_url
  end
end
