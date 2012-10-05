class SessionsController < ApplicationController
  def new
  end

  def create
    auth = request.env['omniauth.auth']
    user = User.find_by_provider_and_uid(auth[:provider], auth[:uid].to_s)
    if user
      session[:user_id] = user.id
      redirect_to dashboard_url
    else
      session[:user_info] = { provider: auth.provider, uid: auth.uid, name: auth.info.nickname }
      redirect_to :signup
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Signed out!"
  end
end
