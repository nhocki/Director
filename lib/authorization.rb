module Sinatra
  module Authorization
 
  def auth
    @auth ||= Rack::Auth::Basic::Request.new(request.env)
  end
 
  def unauthorized!(realm="Please provide your username and password")
    headers 'WWW-Authenticate' => %(Basic realm="#{realm}")
    throw :halt, [ 401, 'Authorization Required' ]
  end
 
  def bad_request!
    throw :halt, [ 400, 'Bad Request' ]
  end
 
  def authorized?
    #request.env['REMOTE_USER']
    admin?
  end
 
  def authorize(username, password)
    if (username==options.admin_user && password==options.admin_password) then
      session[:admin] == true
      return true
    else
      logout
      false
    end
  end
 
  def require_admin
    return if authorized?
    unauthorized! unless auth.provided?
    bad_request! unless auth.basic?
    unauthorized! unless authorize(*auth.credentials)
    request.env['REMOTE_USER'] = auth.username
  end
 
  def admin?
    session[:admin] == true
  end
  
  def logout
    session[:admin] = nil
    @auth = nil
    unauthorized!
  end
 
  end
end
